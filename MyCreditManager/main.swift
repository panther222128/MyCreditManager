//
//  main.swift
//  MyCreditManager
//
//  Created by Jun Ho JANG on 2022/11/24.
//

import Foundation

var isCreditManagerRunning = true
var students = [Student]()
var grades = ["A+", "A", "B+", "B", "C+", "C", "D+", "D", "F"]

struct Student {
    let name: String
    var subjects: [Subject]
}

struct Subject {
    let name: String
    var grade: String
}

func createStudent() {
    print("추가할 할생의 이름을 입력해주세요")
    let studentName = readLine() ?? ""
    if !students.filter( { $0.name == studentName } ).isEmpty  {
        print("\(studentName)은/는 이미 존재하는 학생입니다. 추가하지 않습니다.")
    } else if studentName == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    } else {
        students.append(Student(name: studentName, subjects: []))
    }
}

func createGradeWith() {
    print("""
          성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해주세요.
          입력예) Mickey Swift A+
          만약에 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다.
          """)
    
    let elements = readLine() ?? ""
    let elementsArray = elements.split(separator: " ").map { String($0) }
    if elementsArray.count != 3 {
        print("성적이 양식에 맞게 입력되지 않았습니다. 다시 시도해주세요.")
    } else {
        if grades.contains(elementsArray.last!) {
            if let studentIndex = students.firstIndex(where: { $0.name == elementsArray.first! } ) {
                if let subjectIndex = students[studentIndex].subjects.firstIndex(where: { $0.name == elementsArray[1] } ) {
                    students[studentIndex].subjects[subjectIndex].grade = elementsArray.last!
                } else {
                    let subject = Subject(name: elementsArray[1], grade: elementsArray.last!)
                    students[studentIndex].subjects.append(subject)
                }
                print("\(elementsArray.first!) 학생의 \(elementsArray[1]) 과목이 \(elementsArray.last!)로 추가(변경)되었습니다.")
            }
        } else {
            print("성적이 양식에 맞게 입력되지 않았습니다. 다시 시도해주세요.")
        }
    }
}

func readAverageGrade() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    let studentName = readLine() ?? ""
    if !students.filter( { $0.name == studentName } ).isEmpty  {
        print("\(studentName)은/는 이미 존재하는 학생입니다. 추가하지 않습니다.")
    } else if studentName == "" {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    } else {
        
    }
    
}

func deleteStudent() {
    print("삭제할 학생의 이름을 입력해주세요")
    let studentName = readLine() ?? ""
    if students.filter( { $0.name == studentName } ).isEmpty {
        print("\(studentName) 학생을 찾지 못했습니다.")
    } else {
        if let index = students.firstIndex(where: { $0.name == studentName }) {
            students.remove(at: index)
            print("\(studentName) 학생을 삭제하였습니다.")
        } else {
            print("\(studentName) 학생을 찾지 못했습니다.")
        }
    }
}

func deleteGrade() {
    print("""
          성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요
          """)
    
    let elements = readLine() ?? ""
    let elementsArray = elements.split(separator: " ").map { String($0) }
    if elementsArray.count != 2 {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    } else {
        if let studentIndex = students.firstIndex(where: { $0.name == elementsArray.first! } ) {
            if let subjectIndex = students[studentIndex].subjects.firstIndex(where: { $0.name == elementsArray[0] } ) {
                students[studentIndex].subjects.remove(at: subjectIndex)
                print("\(elementsArray.first!) 학생의 \(elementsArray.last!) 과목의 성적이 삭제되었습니다.")
            } else {
                print("\(elementsArray.first!) 학생을 찾지 못했습니다.")
            }
        } else {
            print("\(elementsArray.first!) 학생을 찾지 못했습니다.")
        }
    }
}

func calculateAverageGrade() {
    print("평점을 알고싶은 학생의 이름을 입력해주세요")
    
    var subjects = [Subject]()
    let studentName = readLine() ?? ""
    if students.filter( { $0.name == studentName } ).isEmpty {
        print("입력이 잘못되었습니다. 다시 확인해주세요.")
    } else {
        if let index = students.firstIndex(where: { $0.name == studentName }) {
            subjects = students[index].subjects
        } else {
            print("\(studentName) 학생을 찾지 못했습니다.")
        }
    }
    
    var sum: Double = 0
    subjects.forEach( {
        if $0.grade == grades[0] {
            sum += 4.50
        } else if $0.grade == grades[1] {
            sum += 4.00
        } else if $0.grade == grades[2] {
            sum += 3.50
        } else if $0.grade == grades[3] {
            sum += 3.00
        } else if $0.grade == grades[4] {
            sum += 2.50
        } else if $0.grade == grades[5] {
            sum += 2.00
        } else if $0.grade == grades[6] {
            sum += 1.50
        } else if $0.grade == grades[7] {
            sum += 1.00
        } else {
            sum += 0.00
        }
    } )
    let count = Double(subjects.count)
    let average = sum / count
    
    subjects.forEach( { print("$\($0.name): \($0.grade)") } )
    print("평점 : \(average)")
}

while isCreditManagerRunning {
    
    print("""
          원하는 기능을 입력해주세요
          1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료
          """)
    
    let inputOption  = readLine() ?? ""
    
    switch inputOption {
    case "1":
        createStudent()
        
    case "2":
        deleteStudent()
        
    case "3":
        createGradeWith()
        
    case "4":
        deleteGrade()
        
    case "5":
        calculateAverageGrade()
        
    case "X":
        print("프로그램을 종료합니다.")
        isCreditManagerRunning.toggle()
        
    default:
        print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        
    }
    
}
