#ifndef _WHATREALLYHAPPENED_MACROS_H_
#define _WHATREALLYHAPPENED_MACROS_H_

#include <whatreallyhappened/ext/mp.h>

#define ELEVENTH_ARGUMENT(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...) a11
#define COUNT_ARGUMENTS(...) ELEVENTH_ARGUMENT(dummy, ## __VA_ARGS__, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

#define WRH_PASTE(x, y) WRH_PASTEINNER(x, y)
#define WRH_PASTEINNER(x, y) x ## y
#define wrh_log(...) WRH_PASTE(wrh_log, COUNT_ARGUMENTS(__VA_ARGS__))(__VA_ARGS__)
#define wrh_log0() wrh_log(NULL, NULL)
#define wrh_log1(a1) wrh_log(a1, NULL)
#define wrh_log2(a1, a2) wrh_log(a1, a2)
#define wrh_log3(a1, a2, a3) wrh_log(a1, a2, a3)
#define wrh_log4(a1, a2, a3, a4) wrh_log(a1, a2, a3, a4)
#define wrh_log5(a1, a2, a3, a4, a5) wrh_log(a1, a2, a3, a4, a5)
#define wrh_log6(a1, a2, a3, a4, a5, a6) wrh_log(a1, a2, a3, a4, a5, a6)
// meh.. need more

#define WRH_WRAP(...) \
	MPP_BEFORE(1, wrh_push(__VA_ARGS__)) \
	MPP_AFTER(2, wrh_pop(NULL))

#endif /* _WHATREALLYHAPPENED_MACROS_H_ */
