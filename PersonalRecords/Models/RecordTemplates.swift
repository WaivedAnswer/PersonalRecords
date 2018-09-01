//
//  RecordTemplates.swift
//  PersonalRecords
//
//  Created by Quinn Ramsay on 2018-09-01.
//  Copyright © 2018 Quinnter. All rights reserved.
//

import Foundation

enum RecordTemplates {
    // must add templates to this list and their value separately
    // order doesn't matter
    static let allTemplates : [TemplateData] =
        [
            Run10K,
            Run5K,
            RunHalfMarathon,
            RunMarathon,
            TriOlympic,
            TriSprint,
            TriXterra,
            OCRSpartanSprint,
            OCRSpartanSuper,
            OCRSpartanBeast,
            ArmHang,
            Squat,
            Deadlift,
            Clean,
            CleanAndJerk,
            OHSquat,
            FSquat,
            StrictPress,
            PushPress,
            BenchPress,
            PullUp,
            ChinUp,
            PushUp,
            SitUp
    ]
    
    static let Run10K = TemplateData( id: UUID(uuidString: "84140b04-7f1f-4b48-b7f5-4da73fddb934")!,
                                      title: "10K Run",
                                      type: RecordType.Time,
                                      sport: Sport.Running,
                                      description: "")
    static let Run5K = TemplateData(id: UUID(uuidString: "f719cf11-0098-4832-ab74-547a45c0d6b8")!,
                                    title: "5K Run",
                                    type: RecordType.Time,
                                    sport: Sport.Running )
    static let RunHalfMarathon = TemplateData(id: UUID(uuidString: "29317622-0ffe-46a4-8a7a-0de969bfc68e")!,
                                              title: "Half-Marathon Run",
                                              type: RecordType.Time,
                                              sport: Sport.Running)
    static let RunMarathon = TemplateData(id: UUID(uuidString: "5d692683-e42b-4210-a114-503a0d455437")!,
    title: "Marathon Run",
    type: RecordType.Time,
    sport: Sport.Running )
    
    static let TriOlympic = TemplateData(id: UUID(uuidString: "c4661765-976a-4d50-b2ef-ce5e11b6c112")!,
    title: "Olympic Triathlon",
    type: RecordType.Time,
    sport: Sport.Triathlon )
    
    static let TriSprint = TemplateData(id: UUID(uuidString: "c8f1021c-f107-432e-8613-0f2e1bb16300")!,
    title: "Sprint Triathlon",
    type: RecordType.Time,
    sport: Sport.Triathlon )
    
    static let TriXterra = TemplateData(id: UUID(uuidString: "680f4135-5ed4-4fb5-b1ee-9c3a047a8ecc")!,
    title: "Xterra Triathlon",
    type: RecordType.Time,
    sport: Sport.Triathlon )
    
    static let OCRSpartanSprint = TemplateData(id: UUID(uuidString: "bd1c1cb2-3095-4a2c-8d7e-17f1cfd6fd6c")!,
    title: "Spartan Sprint",
    type: RecordType.Time,
    sport: Sport.ObstacleCourseRacing )
    
    static let OCRSpartanSuper = TemplateData(id: UUID(uuidString: "3257c108-301f-4a07-9ce2-9a581ff3eda8")!,
    title: "Spartan Super",
    type: RecordType.Time,
    sport: Sport.ObstacleCourseRacing )
    
    static let OCRSpartanBeast = TemplateData(id: UUID(uuidString: "6c4c0eb8-92d0-4cca-b907-fb2d171f9636")!,
    title: "Spartan Beast",
    type: RecordType.Time,
    sport: Sport.ObstacleCourseRacing )
    
    static let ArmHang = TemplateData(id: UUID(uuidString: "a82e38ff-0271-4db3-a1b9-99632703dc6a")!,
    title: "Dead-arm hang",
    type: RecordType.Time,
    sport: Sport.Weightlifting )
    
    static let Squat = TemplateData(id: UUID(uuidString: "64a4fba1-a180-4710-9d35-c22a636b765f")!,
    title: "Squat",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let Deadlift = TemplateData(id: UUID(uuidString: "d40934f1-0968-46f2-bf67-a10571b985c9")!,
    title: "Deadlift",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let Clean = TemplateData(id: UUID(uuidString: "38032843-a8c1-48e1-a81f-d84f5eab07c9")!,
    title: "Clean",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let CleanAndJerk = TemplateData(id: UUID(uuidString: "e910a054-40fc-401f-9bd0-1e80f3fa6b23")!,
    title: "Clean & Jerk",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let OHSquat = TemplateData(id: UUID(uuidString: "3ffbc8c9-0e30-48dc-a45b-397cff328e2c")!,
    title: "Overhead Squat",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let FSquat = TemplateData(id: UUID(uuidString: "1a3a3e2d-42b4-4aab-a178-88aa785a30ba")!,
    title: "Front Squat",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let StrictPress = TemplateData(id: UUID(uuidString: "5ea7f4ca-81dd-425b-adec-d6d2fb7a1fa1")!,
    title: "Strict Press",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let PushPress = TemplateData(id: UUID(uuidString: "b704fb9d-8f37-4eef-b6ce-0c3386db0a05")!,
    title: "Push Press",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let BenchPress = TemplateData(id: UUID(uuidString: "6b8db684-37ef-431c-bc0a-4a44cf9bbec0")!,
    title: "Bench Press",
    type: RecordType.Weight,
    sport: Sport.Weightlifting )
    
    static let PullUp = TemplateData(id: UUID(uuidString: "bfeac06a-01f1-4c22-8a0a-4bb22b314512")!,
    title: "Pull-up",
    type: RecordType.Repetition,
    sport: Sport.Weightlifting )
    
    static let ChinUp = TemplateData(id: UUID(uuidString: "1bd135cf-3472-4875-9837-dd0ae8505c38")!,
    title: "Chin-up",
    type: RecordType.Repetition,
    sport: Sport.Weightlifting )
    
    static let PushUp = TemplateData(id: UUID(uuidString: "972947b0-5256-4a64-a057-33ea05c86265")!,
    title: "Push-up",
    type: RecordType.Repetition,
    sport: Sport.Weightlifting )
    
    static let SitUp = TemplateData(id: UUID(uuidString: "b88b2812-3046-4600-9691-4d39911c098c")!,
    title: "Sit-up",
    type: RecordType.Repetition,
    sport: Sport.Weightlifting )

}


