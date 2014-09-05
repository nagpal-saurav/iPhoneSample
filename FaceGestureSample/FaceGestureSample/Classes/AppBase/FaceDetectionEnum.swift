//
//  FaceDetectionEnum.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 21/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import Foundation

enum faceMovementTypeEnum : UInt32{
    case faceMoveRight = 1, faceMoveLeft, faceMoveTypeNone
}

enum FGdetectionTypeEnum : UInt32{
    case FGdetectionTypeFace = 1, FGdetectionTypeEyesBlink = 2, FGdetectionTypeSmile = 4
}

enum FGEyeDetectionDetailEnum : UInt32{
    case FGEyeDetectionLeftEyeBlink = 1, FGEyeDetectionRightEyeBlink
}


enum appErrorCodeEnum: Int{
    case cameraDoesNotExist = 100,frontCameraNotFound, outputDeviceNotFound, inputDeviceNotFound, coreVideooutputNotAdded, AvVideooutputNotAdded
}
