//
//  FaceDetectionEnum.swift
//  FaceGestureSample
//
//  Created by Saurav Nagpal on 21/07/14.
//  Copyright (c) 2014 Saurav Nagpal. All rights reserved.
//

import Foundation

enum faceMovementTypeEnum{
    case faceMoveRight, faceMoveLeft
}

enum appErrorCodeEnum: Int{
    case cameraDoesNotExist = 100,frontCameraNotFound, outputDeviceNotFound, inputDeviceNotFound
}