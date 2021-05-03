#ifndef _WHATREALLYHAPPENED_WRH_H_
#define _WHATREALLYHAPPENED_WRH_H_

#include <stdint.h>
#include <uuid/uuid.h>

int wrh_open(char *filename, char *mode, int always_flush);

void wrh_log(char *name, char *message, ...);

void wrh_push(char *message, ...);

void wrh_save(char **info);

void wrh_load(const char *const info);

void wrh_pop(char *message, ...);

void wrh_write(char *line);

#endif /* _WHATREALLYHAPPENED_WRH_H_ */
