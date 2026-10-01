#include "cmd_data.h"
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

// Allocating a node and initializing its fields.
CLObj *new_obj(CLObjType type, char *name)
{
    CLObj *node = malloc(sizeof *node);

    if (node == NULL)
    {
        fprintf(stderr, "Unable to allocate a tree node.\n");
        exit(EXIT_FAILURE);
    }

    node->type = type;
    node->name = name;
    node->ival = 0;
    node->fval = 0.0;

    node->args = NULL;
    node->body = NULL;
    node->next = NULL;

    return node;
}


static int count_list(const CLObj *node)
{
    int count = 0;

    while (node != NULL)
    {
        count++;
        node = node->next;
    }

    return count;
}
void evaluate(CLObj *e)
{
    while (e != NULL)
    {
        switch (e->type)
        {
            case PROGRAM:
                printf("PROGRAM %d\n", count_list(e->args));
                evaluate(e->args);
                break;

            case COMMAND:
                printf("COMMAND %s\n", e->name);
                printf("ARGS %d\n", count_list(e->args));
                evaluate(e->args);
                break;

            case FUNCTION:
                printf("FUNCTION %s\n", e->name);
                printf("ARGUMENTS %d\n", count_list(e->args));
                evaluate(e->args);
                printf("BODY %d\n", count_list(e->body));
                evaluate(e->body);
                break;

            case SYMBOL:
                printf("SYMBOL %s\n", e->name);
                break;

            case INTEGER:
                printf("INTEGER %d\n", e->ival);
                break;

            case FLOAT:
                printf("FLOAT %f\n", e->fval);
                break;

            case STRING:
                printf("STRING %zu %s\n",
                       strlen(e->name), e->name);
                break;

            case VARIABLE:
                printf("VARREF %s\n", e->name);
                break;

            case FLAG:
                printf("FLAG %s\n", e->name);
                break;

            case LONGOPT:
                printf("LONG OPT %s\n", e->name);
                evaluate(e->args);
                break;
        }

        e = e->next;
    }
}
