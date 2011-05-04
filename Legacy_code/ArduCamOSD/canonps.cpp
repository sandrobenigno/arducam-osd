/*
ArduCam OSD - The Arduino based Remote Camera Control and OSD.

File : ArduCamOSD.pde
Version : v0.5, 25 november 2010

Author(s): Sandro Benigno (USB host and PTP library from Oleg Mazurov - circuitsathome.com)

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.  You should have received a copy of the GNU General Public License along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include "canonps.h"

CanonPS::CanonPS(uint8_t addr, uint8_t epin, uint8_t epout, uint8_t epint, uint8_t nconf, PTPMAIN pfunc)
: PTP(addr, epin, epout, epint, nconf, pfunc)
{
}

uint16_t CanonPS::EventCheck(PTPReadParser *parser)
{
	uint16_t	ptp_error	= PTP_RC_GeneralError;
	OperFlags	flags		= { 0, 0, 0, 1, 1, 0 };

	if ( (ptp_error = Transaction(PTP_OC_PS_CheckEvent, &flags, NULL, parser)) != PTP_RC_OK)
		Message(PSTR("PS EventCheck: Error."), ptp_error);

	return ptp_error;
}

uint16_t CanonPS::Initialize(bool binit)
{
	uint16_t	ptp_error;

	if (binit)
	{
		if ((ptp_error = Operation(PTP_OC_PS_StartShootingMode, 0, NULL)) != PTP_RC_OK)
			Message(PSTR("PC Connect mode failed: "), ptp_error);
	}
	else
	{
		if ((ptp_error = Operation(PTP_OC_PS_EndShootingMode, 0, NULL)) != PTP_RC_OK)
			Message(PSTR("PC Connect mode failed: "), ptp_error);
	}
	return ptp_error;
}

uint16_t CanonPS::Capture()
{
	uint16_t	ptp_error;

	if ((ptp_error = Operation(PTP_OC_PS_InitiateCaptureInMemory, 0, NULL)) != PTP_RC_OK)
		Message(PSTR("Capture: Error: "), ptp_error);

	return ptp_error;
}

uint16_t CanonPS::FocusLock()
{
	uint16_t	ptp_error;

	if ((ptp_error = Operation(PTP_OC_PS_FocusLock, 0, NULL)) != PTP_RC_OK)
		Message(PSTR("Focus Lock - Error: "), ptp_error);

	return ptp_error;
}

uint16_t CanonPS::FocusUnlock()
{
	uint16_t	ptp_error;

	if ((ptp_error = Operation(PTP_OC_PS_FocusUnlock, 0, NULL)) != PTP_RC_OK)
		Message(PSTR("Focus Unlock - Error: "), ptp_error);

	return ptp_error;
}

uint16_t CanonPS::ViewFinder(bool bval)
{
	uint16_t	ptp_error;

	if (bval)
	{
		if ((ptp_error = Operation(PTP_OC_PS_ViewfinderOn, 0, NULL)) != PTP_RC_OK)
			Message(PSTR("Viewfinder ON - Error: "), ptp_error);
	}
	else
	{
		if ((ptp_error = Operation(PTP_OC_PS_ViewfinderOff, 0, NULL)) != PTP_RC_OK)
			Message(PSTR("Viewfinder ON - Error: "), ptp_error);
	}
	return ptp_error;
}