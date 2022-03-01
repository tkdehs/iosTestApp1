//
//  Util_UIImage.swift
//  CodeAble
//
//  Created by Ahngunism on 2022/01/17.
//  Copyright © 2022 OKPOS. All rights reserved.
//

import UIKit

extension UIImage {
    /// base 64 컨버트
    /// - Returns: base 64 문자열
    func toBase64() -> String? {
        guard let imageData = self.pngData() else { return nil }
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
    }
    
    /// 비율 유지 이미지 사이즈 조정
    /// - Parameters:
    ///   - cfMaxWidth: 이미지 최대 Width
    ///   - cfMaxHeight: 이미지 최대 Height
    /// - Returns: 이미지
    func resizeImage( cfMaxWidth: CGFloat, cfMaxHeight: CGFloat) -> UIImage? {
        var actualWidth: CGFloat = self.size.width
        var actualHeight: CGFloat = self.size.height
        
        var imgRatio: CGFloat = actualWidth / actualHeight
        let maxRatio: CGFloat = cfMaxWidth / cfMaxHeight

        if actualHeight > cfMaxHeight || actualWidth > cfMaxWidth {
            if imgRatio < maxRatio {
                imgRatio = cfMaxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = cfMaxHeight
                
            } else if imgRatio > maxRatio {
                imgRatio = cfMaxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = cfMaxWidth
                
            } else {
                actualHeight = cfMaxHeight
                actualWidth = cfMaxWidth
            }
        }
        
        UIGraphicsBeginImageContextWithOptions(CGSize.init(width: actualWidth, height: actualHeight), false, 1.0)
        self.draw(in: CGRect.init(x: 0, y: 0, width: actualWidth, height: actualHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    /// 정사각 이미지 크롭
    /// - Returns: 이미지
    func cropImageToSquare() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        var imageHeight = self.size.height
        var imageWidth = self.size.width

        if imageHeight > imageWidth {
            imageHeight = imageWidth
        }
        else {
            imageWidth = imageHeight
        }

        let size = CGSize(width: imageWidth, height: imageHeight)

        let refWidth : CGFloat = CGFloat(cgImage.width)
        let refHeight : CGFloat = CGFloat(cgImage.height)

        let x = (refWidth - size.width) / 2
        let y = (refHeight - size.height) / 2

        let cropRect = CGRect.init(x: x, y: y, width: size.height, height: size.width)
        if let imageRef = cgImage.cropping(to: cropRect) {
            return UIImage(cgImage: imageRef, scale: 0, orientation: self.imageOrientation)
        }

       return nil
    }
    
    /// 이미지 방향 고정
    /// - Returns: 방향 고정 이미지
    func fixedOrientation() -> UIImage {
        if imageOrientation == UIImage.Orientation.up { return self }
        
        var transform: CGAffineTransform = CGAffineTransform.identity
        
        switch imageOrientation {
        case UIImage.Orientation.down, UIImage.Orientation.downMirrored:
                transform = transform.translatedBy(x: size.width, y: size.height)
                transform = transform.rotated(by: CGFloat.pi)
                break
            case UIImage.Orientation.left, UIImage.Orientation.leftMirrored:
                transform = transform.translatedBy(x: size.width, y: 0)
                transform = transform.rotated(by: CGFloat.pi/2)
                break
            case UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                transform = transform.translatedBy(x: 0, y: size.height)
                transform = transform.rotated(by: -CGFloat.pi/2)
                break
            case UIImage.Orientation.up, UIImage.Orientation.upMirrored:
                break
            default: break
        }
        
        switch imageOrientation {
            case UIImage.Orientation.upMirrored, UIImage.Orientation.downMirrored:
                transform.translatedBy(x: size.width, y: 0)
                transform.scaledBy(x: -1, y: 1)
                break
            case UIImage.Orientation.leftMirrored, UIImage.Orientation.rightMirrored:
                transform.translatedBy(x: size.height, y: 0)
                transform.scaledBy(x: -1, y: 1)
            case UIImage.Orientation.up, UIImage.Orientation.down, UIImage.Orientation.left, UIImage.Orientation.right:
                break
            default: break
        }
        
        let ctx: CGContext = CGContext(data: nil,
                                       width: Int(size.width),
                                       height: Int(size.height),
                                       bitsPerComponent: self.cgImage!.bitsPerComponent,
                                       bytesPerRow: 0,
                                       space: self.cgImage!.colorSpace!,
                                       bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        ctx.concatenate(transform)
        
        switch imageOrientation {
            case UIImage.Orientation.left, UIImage.Orientation.leftMirrored, UIImage.Orientation.right, UIImage.Orientation.rightMirrored:
                ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.height, height: size.width))
            default:
                ctx.draw(self.cgImage!, in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
                break
        }
        
        let cgImage: CGImage = ctx.makeImage()!
        
        return UIImage(cgImage: cgImage)
    }
    
    /// 반전 이미지 변환
    /// - Returns: 반전 이미지
    func invertedImage() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        let ciImage = CoreImage.CIImage(cgImage: cgImage)
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setDefaults()
        filter.setValue(ciImage, forKey: kCIInputImageKey)
        let context = CIContext(options: nil)
        guard let outputImage = filter.outputImage else { return nil }
        guard let outputImageCopy = context.createCGImage(outputImage, from: outputImage.extent) else { return nil }
        return UIImage(cgImage: outputImageCopy, scale: self.scale, orientation: .up)
    }
    
    /// 블러 효과 추가
    /// - Parameter blurValue: 블러값
    /// - Returns: 결과 이미지
    func applyBlurEffect(blurValue: CGFloat = 50) -> UIImage? {
        let context = CIContext(options: nil)
        let inputImage = CIImage(image: self)
        let originalOrientation = self.imageOrientation
        let originalScale = self.scale
        
        let filter = CIFilter(name: "CIGaussianBlur")
        filter?.setValue(inputImage, forKey: kCIInputImageKey)
        filter?.setValue(blurValue, forKey: kCIInputRadiusKey)
        let outputImage = filter?.outputImage
        
        var cgImage:CGImage?
        if let asd = outputImage, let extent = inputImage?.extent {
            cgImage = context.createCGImage(asd, from: extent)
        }
        
        if let cgImageA = cgImage {
            return UIImage(cgImage: cgImageA, scale: originalScale, orientation: originalOrientation)
        }
        return nil
    }
    
    
    /// 이미지 병합
    /// - Parameter topImage: 상단으로 올라올 이미지
    /// - Returns: 병합된 이미지
    func mergeWith(topImage: UIImage?) -> UIImage? {
        guard let topImage = topImage  else { return nil }
        let bottomImage = self
        
        UIGraphicsBeginImageContext(size)
        
        let areaSize = CGRect(x: 0, y: 0, width: bottomImage.size.width, height: bottomImage.size.height)
        bottomImage.draw(in: areaSize)
        topImage.draw(in: areaSize, blendMode: .normal, alpha: 1.0)
        if let mergedImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return mergedImage
        } else {
            print("Image Merge Fail")
            return nil
        }
        
    }
}
