/*
 * Copyright (c) 2019 Johannes Fischer <fischer.jh@gmail.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. Neither the name of mosquitto nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
 * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
 * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
 * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
 * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
 * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 */

/**
 * @group Logger
 * @description Logger controller to allow for clients to submit log messages.
 */ 
@SuppressWarnings('PMD.ClassNamingConventions')
public with sharing class rflib_LoggerController {
    
    /**
     * Log action to be invoked from the client. THe statment will be logged using a custom settings logger.
     * This controller is used by the rflib_logger LWC module.
     * 
     * @param  level   The level for the log statement.
     * @param  context The context for the log statment. 
     * @param  message message description
     */
    @AuraEnabled
    public static void log(String level, String context, String message){
        rflib_Logger logger = rflib_DefaultLogger.createFromCustomSettings(context);

        switch on level.toUpperCase() {
            when 'DEBUG' {
                logger.debug(message);
            }

            when 'INFO' {
                logger.info(message);
            }

            when 'WARN' {
                logger.warn(message);
            }

            when 'ERROR' {
                logger.error(message);
            }

            when 'FATAL' {
                logger.fatal(message);
            }

            when else {
                logger.fatal('Failed to log {0} message for {1}: {2}', new List<Object> { level, context, message });
            }
        }
    }
}