#ifndef CMD_DATA_H
#define CMD_DATA_H

//use tagged union to make tree just holds data

typedef struct CLObj
{
    int name;
    float fl;
    char* string;
} CLObj;

void evaluate(CLObj *); //use the diff types ints 
//works with parse
#endif
