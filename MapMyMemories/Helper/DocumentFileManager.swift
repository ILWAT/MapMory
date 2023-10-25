//
//  FileManager.swift
//  MapMyMemories
//
//  Created by 문정호 on 10/23/23.
//

import Foundation
import UIKit

enum ImageFileNameExtension{
    case jpeg(fileName: String)
    
    var getFileName: String{
        switch self {
        case .jpeg(let fileName):
            return fileName+".jpeg"
        }
    }
}

final class DocumentFileManager{
    public static let shared = DocumentFileManager()
    
    private init(){}
    
    //도큐먼트 폴더에 이미지를 저장하는 메서드
    func saveImageToDocument(fileName: ImageFileNameExtension, image: UIImage){
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {return}
        //2. 저장할 경로 설정(세부 경로, 이미지를 저장할 위치)
        let fileName = fileName.getFileName
        let fileURL = documentDirectory.appendingPathComponent(fileName) //새로운 폴더를 생성 하는 메서드
        //3. 이미지 변환
        guard let data = image.jpegData(compressionQuality: 0.5) else {return}
        
        //4. 이미지 저장
        do{
            try data.write(to: fileURL)
        } catch let error {
            print("file save error", error)
        }
    }
    
    func loadImageFromDocument(fileName: ImageFileNameExtension) -> UIImage? {
            //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            //2. 경로 설정(세부 경로, 이미지가 저장되어 있는 위치
        let fileName = fileName.getFileName
        let fileURL = documentDirectory.appendingPathComponent(fileName)
            
        if FileManager.default.fileExists(atPath: fileURL.path) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return nil
            
        }
    }
    
    ///도큐먼트에 있는 파일을 삭제한다.
    func removeImageFromDocument(fileName: ImageFileNameExtension){
        //1. 도큐먼트 경로 찾기
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        //2. 경로 설정(세부 경로, 이미지가 저장되어 있는 위치)
        let fileName = fileName.getFileName
        
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do{
            try FileManager.default.removeItem(at: fileURL)
        } catch let error{
            print("File remove error",error)
        }
    }
    
}
