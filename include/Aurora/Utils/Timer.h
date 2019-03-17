#ifndef AURORA_TIMER_H
#define AURORA_TIMER_H

//#include <psp2/types.h> //psptypes.h
#include <stdio.h>
#include <psp2/rtc.h> //psprtc.h

namespace Aurora
{
	namespace Utils
	{

		class Timer
		{
			public:
				Timer();
				virtual ~Timer();

				double GetDeltaTime( void );	// Returns the delta time

			private:
				double dt;

				SceRtcTick timeNow;
				SceRtcTick timeLastAsk;
				uint32_t tickResolution;
		};

	}
}

#endif /* TIMER_H_ */

