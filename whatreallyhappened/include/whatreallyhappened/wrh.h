#ifndef _WHATREALLYHAPPENED_WRH_H_
#define _WHATREALLYHAPPENED_WRH_H_

#include <stdint.h>
#include <uuid/uuid.h>

enum whatreallyhappened_error {
    WRH_ERR_NONE = 0,
    WRH_ERR__COUNT,
};

const char *whatreallyhappened_error_lookup[WRH_ERR__COUNT] = {
    "Success",
};

struct whatreallyhappened {
    uuid_t wrh_task;
    size_t wrh_maxlevels;
    size_t wrh_nlevels;
    uint32_t *wrh_levels;
    enum whatreallyhappened_error wrh_errno;

    uint32_t wrh_continued;
    pthread_mutex_t *wrh_lock;
};

struct whatreallyhappened *wrh_create();

#endif /* _WHATREALLYHAPPENED_WRH_H_ */
