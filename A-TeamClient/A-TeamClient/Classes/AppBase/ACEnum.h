//
//  ACEnum.h
//  A-TeamClient
//
//  Created by Jakir Hussain on 7/25/14.
//  Copyright (c) 2014 Jakir Hussain. All rights reserved.
//

#ifndef A_TeamClient_ACEnum_h
#define A_TeamClient_ACEnum_h

typedef enum light_On_Off_Status_enum{
    first_room_light_pressed =10,
    second_room_light_pressed=9,
    third_room_light_pressed=11
}light_On_Off_Status;

typedef enum BLE_Distance_Status_enum{
    BLE_Distance_Immediate = 0,
    BLE_Distance_Near,
    BLE_Distance_Far,
    BLE_Distance_Unknown
}BLE_Distance_Status;

#endif
