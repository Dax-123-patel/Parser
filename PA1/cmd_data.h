#ifndef CMD_DATA_H
#define CMD_DATA_H


// THe node tells evaluate () what to print
typedef enum{
     PROGRAM,
    COMMAND,
    FUNCTION,
    SYMBOL,
    INTEGER,
    FLOAT,
    STRING,
    VARIABLE,
    FLAG,
    LONGOPT
} CLObjType;

typedef struct CLObj
{
    CLObjType type;
    char *name;
    int ival;
    double fval;

    struct CLObj *args; // First argument/parameter
    struct CLObj *body; // First item in a function's body
    struct CLObj *next; // NExt item in the same list
} CLObj;

CLObj *new_obj(CLObjType type, char *name); // Create a node for the parser

void evaluate(CLObj *);
#endif
