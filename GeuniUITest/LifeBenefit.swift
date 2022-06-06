//
//  Life.swift
//  SOL
//
//  Created by 60157085 on 2022/05/30.
//

public struct LifeBenefit :Hashable{
    public static func == (lhs: LifeBenefit, rhs: LifeBenefit) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    public var id:String
    
    public var title:String?
    ///모델 타입
    public var lifeBenefitType:LifeBenefitType
    //운세
    public var fortunes:[LifeBenefitFortune]?
    //이벤트
    public var events:[LifeBenefitEvent]?
    //쏠퀴즈
    public var solQuizs:[LifeBenefitSolQuiz]?
    //헤이영 퀴즈
    public var heyYoungQuizs:[LifeBenefitHeyYoungQuiz]?
    //헤이영 쏠테크
    public var heyYoungSolTechs:[LifeBenefitSolTech]?
    //스마트오퍼
    public var smartOffers:[LifeBenefitSmartOffer]?
    //더 특별한 혜택
    public var specials:[LifeBenefitSpecial]?
    //우리동네 혜택
    public var myTowns:[LifeBenefitMyTown]?
    
    public init(
        id:String,
        title:String? = "",
        lifeBenefitType:LifeBenefitType,
        fortunes:[LifeBenefitFortune]? = [],
        events:[LifeBenefitEvent]? = [],
        solQuizs:[LifeBenefitSolQuiz]? = [],
        heyYoungQuizs:[LifeBenefitHeyYoungQuiz]? = [],
        heyYoungSolTechs:[LifeBenefitSolTech]? = [],
        smartOffers:[LifeBenefitSmartOffer]? = [],
        specials:[LifeBenefitSpecial]? = [],
        myTowns:[LifeBenefitMyTown]? = []
    ) {
        self.id = id
        self.lifeBenefitType = lifeBenefitType
        self.fortunes = fortunes
        self.events = events
        self.solQuizs = solQuizs
        self.heyYoungQuizs = heyYoungQuizs
        self.heyYoungSolTechs = heyYoungSolTechs
        self.smartOffers = smartOffers
        self.myTowns = myTowns
    }
    
    public enum LifeBenefitType {
        /// 운세
        case fortune
        /// 이벤트
        case event
        /// 쏠퀴즈
        case solQuiz
        /// 헤이영 퀴즈
        case heyYoungQuiz
        /// 헤이영 쏠테크
        case heyYoungSolTech
        /// 스마트 오퍼
        case smartOffer
        /// 더특별한 혜택
        case specialBenefit
        /// 우리동네 혜택
        case myTownBenefit
    }
}

public struct LifeBenefitEvent {
    /// 타이틀
    public var title:String
    /// URL
    public var url:String
    /// IMAGE URL
    public var imageUrl:String
    /// 배경 색상///
    public var backgroundColor:String
    
    public init(
        title:String,
        url:String,
        imageUrl:String,
        backgroundColor:String
    ) {
        self.title = title
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
    }
}

public struct LifeBenefitFortune {
    /// 타이틀
    public var title:String
    /// 본문
    public var content:String
    /// URL
    public var url:String
    /// 이미지 URL
    public var imageUrl:String
    /// 배경 색상
    public var backgroundColor:String
    
    public init(
        title:String,
        content:String,
        url:String,
        imageUrl:String,
        backgroundColor:String
    ) {
        self.title = title
        self.content = content
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
    }
}

public struct LifeBenefitHeyYoungQuiz {
    /// 헤이영 퀴즈 타이틀
    public var quizTitle:String
    /// 퀴즈 URL
    public var url:String
    /// 퀴즈 이미지 URL
    public var imageUrl:String
    /// 퀴즈 배경색
    public var backgroundColor:String
    /// 버튼 타이틀
    public var buttonTitle:String
    
    public init(quizTitle:String,
                url:String,
                imageUrl:String,
                backgroundColor:String,
                buttonTitle:String) {
        self.quizTitle = quizTitle
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
        self.buttonTitle = buttonTitle
    }
}

public struct LifeBenefitMyTown {
    /// 타이틀
    public var title:String
    /// 본문
    public var content:String
    /// URL
    public var url:String
    /// 이미지 URL
    public var imageUrl:String
    /// 배경색
    public var backgroundColor:String
    
    public init(title:String,
                content:String,
                url:String,
                imageUrl:String,
                backgroundColor:String) {
        self.title = title
        self.content = content
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
    }
}

public struct LifeBenefitSmartOffer {
    /// 타이틀
    public var title:String
    /// 본문
    public var content:String
    /// URL
    public var url:String
    /// 이미지 URL
    public var imageUrl:String
    /// 배경색
    public var backgroundColor:String
    
    public init(title:String,
                content:String,
                url:String,
                imageUrl:String,
                backgroundColor:String) {
        self.title = title
        self.content = content
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
    }
}

public struct LifeBenefitSolQuiz {
    /// 쏠퀴즈
    public var solQuiz:String
    /// URL
    public var url:String
    /// 이미지 URL
    public var imageUrl:String
    
    public init(solQuize:String,
                url:String,
                imageUrl:String) {
        self.solQuiz = solQuize
        self.url = url
        self.imageUrl = imageUrl
    }
}

public struct LifeBenefitSolTech {
    /// URL
    public var url:String
    /// 이미지 URL
    public var imageUrl:String
    /// 배경색
    public var backgroundColor:String
    
    public var buttonTitle:String
    
    public init(url:String,
                imageUrl:String,
                backgroundColor:String,
                buttonTitle:String) {
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
        self.buttonTitle = buttonTitle
    }
}

public struct LifeBenefitSpecial {
    /// 타이틀
    public var title:String
    /// 본문
    public var content:String
    /// URL
    public var url:String
    /// 이미지 URL
    public var imageUrl:String
    /// 배경색
    public var backgroundColor:String
    
    public init(title:String,
                content:String,
                url:String,
                imageUrl:String,
                backgroundColor:String) {
        self.title = title
        self.content = content
        self.url = url
        self.imageUrl = imageUrl
        self.backgroundColor = backgroundColor
    }
}
