//
//  RealmManager.swift
//  MapMyMemories
//
//  Created by 문정호 on 2023/09/28.
//

import Foundation
import RealmSwift

final class RealmManager{
    static let shared = RealmManager()
    
    var realm: Realm!
    
    private init() {
        do {self.realm = try Realm()}
        catch { print(error) }
        
        print(realm.configuration.fileURL)
    }
    
    ///해당 제네릭 형태의 테이블의 모든 레코드들을 조회한다.
    func readAllRecord<T: Object>(type: T.Type, completionHandler: @escaping(Results<T>) -> Void){
        completionHandler(realm.objects(T.self))
    }
    
    func readSpecificRecord<T:Object>(type: T.Type, pk: String) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: pk)
    }
    
    ///해당 제네릭 형태의 테이블에 레코드를 삽입한다.
    func writeRecord<T: Object>(data: T) {
        do { try realm.write { realm.add(data) }
        } catch { print(error) }
    }
    
    func deleteRecord<T: Object>(data: T) -> Bool{
        do { 
            try realm.write { realm.delete(data) }
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func deleteEmbeddedListRecord(address: AddressData, memoryIndex: Int) -> Bool{
        do {
            address.memory[memoryIndex].imageURL.forEach { imageURLs in
                _ = DocumentFileManager.shared.removeImageFromDocument(fileName: .jpeg(fileName: imageURLs))
            }
            
            try realm.write {
                address.memory[memoryIndex].emotion.removeAll()
                
                if address.memory.count == 1{
                    realm.delete(address)
                } else {
                    address.memory.remove(at: memoryIndex)
                    print(address.memory)
                }
            }
            
            return true
        } catch {
            print(error)
            return false
        }
        
    }
    
    func updateMemoryRecord(data: AddressData, modifiedData: Memory, index: Int){
        do{ try realm.write { data.memory[index] = modifiedData } }
        catch { print(error) }
    }
    
    func isExistLocation(data: AddressData) -> AddressData?{
        let isExist = realm.object(ofType: AddressData.self, forPrimaryKey: data.coordiante)
        
        return isExist
    }
    
    func upsertMemory(addressData: AddressData, memoryData: Memory){
        do{
            try realm.write({
                addressData.memory.append(memoryData)
            })
        }
        catch { print (error) }
    }
    
    
}
