/*******************************************************************************
Copyright (c) 1983-2016 Advantech Co., Ltd.
********************************************************************************
THIS IS AN UNPUBLISHED WORK CONTAINING CONFIDENTIAL AND PROPRIETARY INFORMATION
WHICH IS THE PROPERTY OF ADVANTECH CORP., ANY DISCLOSURE, USE, OR REPRODUCTION,
WITHOUT WRITTEN AUTHORIZATION FROM ADVANTECH CORP., IS STRICTLY PROHIBITED. 
================================================================================
REVISION HISTORY
--------------------------------------------------------------------------------
$Log: $
--------------------------------------------------------------------------------
 $NoKeywords:  $
*/
/******************************************************************************
*
* Windows Example:
*    FrequencyMeasurement.cs
*
* Example Category:
*    Counter
*
* Description:
*    This example demonstrates how to use Frequency Measurement function.
*
* Instructions for Running:
*    1  Set the 'deviceDescription' for opening the device. 
*	  2  Set the 'profilePath' to save the profile path of being initialized device. 
*    3  Set the 'channelStart' as the start channel of the counter to operate
*	  4  Set the 'channelCount' as the channel count of the counter to operate.
*    5  Set the 'collectionPeriod' to decide period to measure frequency.
*
* I/O Connections Overview:
*    Please refer to your hardware reference manual.
*
******************************************************************************/
using System;
using System.Collections.Generic;
using System.Text;
using System.Threading;
using System.Reflection;
using System.Runtime.InteropServices;
using Automation.BDaq;

namespace Counter_FrequencyMeasurement
{
   class FrequencyMeasurement
   {
      static void Main(string[] args)
      {
         //-----------------------------------------------------------------------------------
         // Configure the following parameters before running the demo
         //-----------------------------------------------------------------------------------
         //The default device of project is demo device, users can choose other devices according to their needs. 
			string deviceDescription = "DemoDevice,BID#0";
         string profilePath = "../../../profile/DemoDevice.xml";
			int channelStart = 0;
			int channelCount = 1;
         double collectionPeriod = 0;
         ErrorCode errorCode = ErrorCode.Success;

         // Step 1: Create a 'FreqMeterCtrl' for Frequency Measurement function.
         FreqMeterCtrl freqMeterCtrl = new FreqMeterCtrl();

         try
         {
            // Step 2: Select a device by device number or device description and specify the access mode.
            // in this example we use ModeWrite mode so that we can fully control the device, including configuring, sampling, etc.
            freqMeterCtrl.SelectedDevice = new DeviceInformation(deviceDescription);
				errorCode = freqMeterCtrl.LoadProfile(profilePath);//Loads a profile to initialize the device.
            if (BioFailed(errorCode))
            {
               throw new Exception();
            }

            // Step 3: Set necessary parameters
            freqMeterCtrl.ChannelStart = channelStart;
				freqMeterCtrl.ChannelCount = channelCount;
				int channelCountMax = freqMeterCtrl.Features.ChannelCountMax;
				for (int i = 0; i < channelStart + channelCount; i++)
				{
					freqMeterCtrl.Channels[i % channelCountMax].CollectionPeriod = collectionPeriod;
				}

            // Step 4: Start Frequency Measurement
            freqMeterCtrl.Enabled = true;

            // Step 5: Read frequency value.
            Console.WriteLine(" FrequencyMeasurement is in progress...");
            Console.WriteLine(" Connect the input signal to CNT#_CLK pin if you choose external clock!");
            Console.WriteLine(" Any key to quit!\n");
            while (!Console.KeyAvailable)
            {
               Thread.Sleep(1000);
               //get frequency value
               double[] buffer = { 0 };
               freqMeterCtrl.Read(1, buffer);
					Console.WriteLine("   channel {0} Current frequency: {1} Hz", channelStart, buffer[0]);
            }

            // Step 6: Stop Frequency Measurement
            freqMeterCtrl.Enabled = false;
         }
         catch(Exception e)
         {
            // Something is wrong
            string errStr = BioFailed(errorCode) ? " Some error occurred. And the last error code is " + errorCode.ToString()
                                          : e.Message;
            Console.WriteLine(errStr);
         }
         finally
         {
            // Step 7: Close device and release any allocated resource.
            freqMeterCtrl.Dispose();
            Console.ReadKey(false);
         }
      }

      static bool BioFailed(ErrorCode err)
      {
         return err < ErrorCode.Success && err >= ErrorCode.ErrorHandleNotValid;
      }
   }
}