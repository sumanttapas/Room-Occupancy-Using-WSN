// $Id: RadioSenseToLedsC.nc,v 1.7 2010-06-29 22:07:17 scipio Exp $

/*									tab:4
 * Copyright (c) 2000-2005 The Regents of the University  of California.  
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * - Redistributions of source code must retain the above copyright
 *   notice, this list of conditions and the following disclaimer.
 * - Redistributions in binary form must reproduce the above copyright
 *   notice, this list of conditions and the following disclaimer in the
 *   documentation and/or other materials provided with the
 *   distribution.
 * - Neither the name of the University of California nor the names of
 *   its contributors may be used to endorse or promote products derived
 *   from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL
 * THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 * INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
 * STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
 * OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Copyright (c) 2002-2003 Intel Corporation
 * All rights reserved.
 *
 * This file is distributed under the terms in the attached INTEL-LICENSE     
 * file. If you do not find these files, copies can be found by writing to
 * Intel Research Berkeley, 2150 Shattuck Avenue, Suite 1300, Berkeley, CA, 
 * 94704.  Attention:  Intel License Inquiry.
 */
 
#include "Timer.h"
#include "RoomOcc.h"

/**
 * Implementation of the RadioSenseToLeds application.  RadioSenseToLeds samples 
 * a platform's default sensor at 4Hz and broadcasts this value in an AM packet. 
 * A RadioSenseToLeds node that hears a broadcast displays the bottom three bits 
 * of the value it has received. This application is a useful test to show that 
 * basic AM communication, timers, and the default sensor work.
 * 
 * @author Philip Levis
 * @date   June 6 2005
 */

module RoomOccC @safe(){
    uses {
        interface Leds;
        interface Boot;
        interface Receive;
        interface AMSend;
        interface Timer<TMilli> as MilliTimer;
        interface Packet;
        interface Read<uint16_t>;
        interface SplitControl as RadioControl;
    }
}
implementation {

    message_t packet;
    bool locked = FALSE;
    uint16_t counter;
    uint16_t flag;
    uint32_t i;

    event void Boot.booted() {
        call RadioControl.start();
        counter = 0;
        flag = 0;
        i = 0;
    }

    event void RadioControl.startDone(error_t err) {
        if (err == SUCCESS) {
            call MilliTimer.startPeriodic(250);
        }
    }

    event void RadioControl.stopDone(error_t err) {}
  
    event void MilliTimer.fired() {
        call Read.read();
    }

    event void Read.readDone(error_t result, uint16_t data) {
        if (locked) {
            return;
        }
        else 
        {
            packet_msg_t* rsm;

            i++;
            if(data < THRESHOLD )
            {
                if(flag == 1 && i < 13)
                {                    
                    flag = 0;
                    call Leds.led0Toggle();  //Indicates that the counter value needs to be updated.
                    if(TOS_NODE_ID == 1)
                        counter --;
                    else if(TOS_NODE_ID == 2)
                        counter ++;
                     //call Leds.set(counter);
                    

                    rsm = (packet_msg_t*)call Packet.getPayload(&packet, sizeof(packet_msg_t));
                    if (rsm == NULL) {
                       return;
                    }
                    rsm->node_id = 200; //Specify that this msg does not signify sensor value change. This boradcast is for basestation 
                    rsm->counter = counter;
                    //rsm->flag = flag;
                    //rsm->sensorVal = data;
                    if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(packet_msg_t)) == SUCCESS) {
                        locked = TRUE;
                    }                                         
                }
                else
                {
                    //send to basestation
                    //call Update.change(&counter);
                    //packet_msg_t* rsm;
                    //i = 0; //to restart the counter value.
                    call Leds.led1Toggle(); //Someone has sent a value to check
                    rsm = (packet_msg_t*)call Packet.getPayload(&packet, sizeof(packet_msg_t));
                    if (rsm == NULL) {
                       return;
                    }
                    rsm->node_id = TOS_NODE_ID; //Specify that this msg does not signify sensor value change. This boradcast is for basestation 
                    rsm->counter = counter;
                    //rsm->flag = flag;
                    //rsm->sensorVal = data;
                    if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(packet_msg_t)) == SUCCESS) {
                        locked = TRUE;
                    }    
                }
            }
            //else if(i > 5)
              //  flag = 0;
        }
    }


    event message_t* Receive.receive(message_t* bufPtr, void* payload, uint8_t len) {
        call Leds.led2Toggle();   //
        if (len != sizeof(packet_msg_t)) {
            return bufPtr;
        }
        else {
            packet_msg_t * rsm = (packet_msg_t*)payload;
            
            uint16_t id = rsm->node_id;
            counter = rsm->counter;
            if(id != 200)
            {
                flag = 1;
                i = 0;
            }
            else if(id == 200)
            {
                flag = 0;
            }
            return bufPtr;
        }
    }

    event void AMSend.sendDone(message_t* bufPtr, error_t error) {
        if (&packet == bufPtr) {
            locked = FALSE;
        }
    }
}
