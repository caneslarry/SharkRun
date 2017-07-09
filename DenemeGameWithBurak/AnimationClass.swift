//
//  AnimationClass.swift
//  JupiterTechs 2017 Copyright (c) all rights reserved.
//
//  Created by BURAK YILDIZ on 14.03.2015.
//  
//

import Foundation
import UIKit
import SpriteKit

class AnimationClass {
    
    
    
    
    var sprite1: SKSpriteNode!
    var animDuration1: TimeInterval!
    
    init(sprite: SKSpriteNode!, animDuration: TimeInterval!) {
        var sprite = sprite, animDuration = animDuration
        
        sprite = self.sprite1
        animDuration = self.animDuration1
        
        
    }
    
    init()
    {
    }
   
    
    
    ///////////////////ROTATE ANIMATIONS/////////////////////////////////
    
    func rotateAnimationsbyAngle (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Kedi
        // Hızlı Dönme Animasyonu(Soldan Sağa) Mayın için kullanılabilir.
        sprite.run(SKAction.repeatForever(
            SKAction.rotate(byAngle: π*5, duration: animDuration)))
        
    }
    
    func rotateAnimationsToAngle (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Köpek
        // Yön Değiştiren Dönme Animasyonu
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.rotate(toAngle: π/2, duration: animDuration),
                SKAction.rotate(toAngle: π, duration: animDuration),
                SKAction.rotate(toAngle: -π/2, duration: animDuration),
                SKAction.rotate(toAngle: π, duration: animDuration),
                ])
            ))
        
    }
    
    func rotateAnimationsToAngleShort (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Kaplumbağa
        // Yön Değiştiren Dönme Animasyonu
        
        // rotateToAngle(duration:shortestUnitArc:)
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.rotate(toAngle: π/2, duration: animDuration, shortestUnitArc:true),
                SKAction.rotate(toAngle: π, duration: animDuration, shortestUnitArc:true),
                SKAction.rotate(toAngle: -π/2, duration: animDuration, shortestUnitArc:true),
                SKAction.rotate(toAngle: π, duration: animDuration, shortestUnitArc:true),
                ])
            ))
    }
    
    
    
    //////////////////ROTATE ANIMATION END /////////////////////////
    
    
    
    
    ///////////////RESIZE ANIMATIONS///////////////////////
    
    
    func resizeByWidth (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Kedi
        // x Ekseninde size değişir
        
        
        // resizeByWidth(height:duration:)
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.resize(byWidth: sprite.size.width, height: -sprite.size.height/2, duration: animDuration),
                SKAction.resize(byWidth: -sprite.size.width, height: sprite.size.height/2, duration: animDuration)
                ])
            ))
    }
    
    
    func resizeHeight (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Köpek
        // Y ekseninde Size Değişir
        
        
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.resize(toWidth: 10, height: 200, duration: animDuration),
                SKAction.resize(toWidth: sprite.size.width, height: sprite.size.height, duration: animDuration)
                ])
            ))
        
    }
    
    func resizeWidtHeight (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Kaplumbağa
        // X ve Y ekseninde size değişir
        
        
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.group([
                    SKAction.resize(toWidth: sprite.size.width*2, duration: animDuration),
                    SKAction.resize(toHeight: sprite.size.height/2, duration: animDuration)
                    ]),
                SKAction.group([
                    SKAction.resize(toWidth: sprite.size.width, duration: animDuration),
                    SKAction.resize(toHeight: sprite.size.height, duration: animDuration)
                    ])
                ])
            ))
        
    }
    
    
    ///////////////////RESIZE ANIMATIONS END//////////////////////////
    
    
    
    
    
    ////////////////SCALE ANIMATIONS //////////////////////
    
    
    func scaleZdirection (_ sprite: SKSpriteNode)  {
        
        //Kedi
        // Ekranın içinden dışa doğru büyür
        
        
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.scale(by: 2.0, duration: 0.5),
              //  SKAction.scaleBy(2.0, duration: 0.5), // now effectively at 4x
                SKAction.scale(to: 1.0, duration: 1.0),
                ])
            ))
        
    }
    
    func scaleYdirection (_ sprite: SKSpriteNode)  {
        
        //Köpek
        // X Ekseninde İçe Doğru İncelme
        
        
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.scaleX(by: 0.25, y:1.25, duration:0.5),
                SKAction.scaleX(by: 0.25, y:1.25, duration:0.5), // now effectively xScale 0.0625, yScale 1.565
                SKAction.scaleX(to: 1.0, y:1.0, duration:1.0),
                ])
            ))
        
    }
    
    func scaleXdirection (_ sprite: SKSpriteNode)  {
        
        //Köpek
        // Enine uzama
        
        
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.group([
                    SKAction.scaleX(to: 3.0, duration:1.0),
                    SKAction.scaleY(to: 0.5, duration:1.0)
                    ]),
                SKAction.group([
                    SKAction.scaleX(to: 1.0, duration:1.0),
                    SKAction.scaleY(to: 1.0, duration:1.0)
                    ])
                ])
            ))
    }
    
    
    ///////////////// SCALE ANIMATIONS END////////////////
    
    
    
    ////////////////// COLOR ANIMATIONS ////////////////
    
    
    
    func redColorAnimation (_ sprite: SKSpriteNode, animDuration: TimeInterval)  {
        
        //Kaplumbağa
        // X ve Y ekseninde size değişir
        
        
        sprite.run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.colorize(with: SKColor.red, colorBlendFactor: 1.0, duration: animDuration),
                SKAction.colorize(withColorBlendFactor: 0.0, duration: animDuration)
                ])
            ))
        
    }
    
    
    
    
    
    
}
