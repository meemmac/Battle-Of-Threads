#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <pthread.h>
#include <unistd.h>

#define MAX_PLAYERS 3

pthread_mutex_t lock;
int scores[MAX_PLAYERS] = {0};
char* players[MAX_PLAYERS] = {"organizer", "junk", "cleaner"};
char* funcs[MAX_PLAYERS] = {"organize_files", "delete_junks", "safe_clean"};

typedef struct {
    char* func;
    char* dir;
    int idx;
} Job;

void* run_job(void* arg) {
    Job* job = (Job*)arg;
    if (strcmp(job->dir, "-") == 0) {
        return NULL;
    }
    char cmd[512];
    snprintf(cmd, sizeof(cmd), "bash battle.sh %s \"%s\"", job->func, job->dir);

    FILE* fp = popen(cmd, "r");
    if (!fp) return NULL;

    char line[256];
    while (fgets(line, sizeof(line), fp)) {
        printf("%s", line);
        int pts;
        if (sscanf(line, "%*[^+] +%d", &pts) == 1) {
            pthread_mutex_lock(&lock);
            scores[job->idx] += pts;
            pthread_mutex_unlock(&lock);
        }
    }
    pclose(fp);
    return NULL;
}

int main(int argc, char* argv[]) {
    if (argc < 4) {
        printf("Usage: %s <organizer_dir> <junk_dir> <cleaner_dir>\n", argv[0]);
        return 1;
    }

    pthread_mutex_init(&lock, NULL);

    pthread_t threads[MAX_PLAYERS];
    Job jobs[MAX_PLAYERS];

    for (int i = 0; i < MAX_PLAYERS; i++) {
        jobs[i].func = funcs[i];
        jobs[i].dir = argv[i + 1];
        jobs[i].idx = i;
        pthread_create(&threads[i], NULL, run_job, &jobs[i]);
    }

    for (int i = 0; i < MAX_PLAYERS; i++)
        pthread_join(threads[i], NULL);

    printf("\n🎉 Battle Over! 🎉\n");
    for (int i = 0; i < MAX_PLAYERS; i++)
        printf("%s: %d Bytes\n", players[i], scores[i]);

    int winner = 0;
    for (int i = 1; i < MAX_PLAYERS; i++)
        if (scores[i] > scores[winner])
            winner = i;

    printf("\n👑 Victor: %s!\n", players[winner]);
    pthread_mutex_destroy(&lock);
    return 0;
}

