#ifndef _WHATREALLYHAPPENED_MACROS_H_
#define _WHATREALLYHAPPENED_MACROS_H_

#include <ext/mp.h>

#define ELEVENTH_ARGUMENT(a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, ...) a11
#define COUNT_ARGUMENTS(...) ELEVENTH_ARGUMENT(dummy, ## __VA_ARGS__, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0)

#define WRH_PASTE(x, y) WRH_PASTEINNER(x, y)
#define WRH_PASTEINNER(x, y) x ## y
#define wrhLogMessage(...) WRH_PASTE(wrhLogMessage, COUNT_ARGUMENTS(__VA_ARGS__))(__VA_ARGS__)
#define wrhLogMessage0() wrhLogMessage(NULL, NULL)
#define wrhLogMessage1(a1) wrhLogMessage(a1, NULL)
#define wrhLogMessage2(a1, a2) wrhLogMessage(a1, a2)
#define wrhLogMessage3(a1, a2, a3) wrhLogMessage(a1, a2, a3)
#define wrhLogMessage4(a1, a2, a3, a4) wrhLogMessage(a1, a2, a3, a4)
#define wrhLogMessage5(a1, a2, a3, a4, a5) wrhLogMessage(a1, a2, a3, a4, a5)
#define wrhLogMessage6(a1, a2, a3, a4, a5, a6) wrhLogMessage(a1, a2, a3, a4, a5, a6)
// meh.. need more

#define WRH_WRAP(...) \
	MPP_BEFORE(1, wrhLogAction(__VA_ARGS__)) \
	MPP_AFTER(2, wrhLogEnd(NULL))

#endif /* _WHATREALLYHAPPENED_MACROS_H_ */
