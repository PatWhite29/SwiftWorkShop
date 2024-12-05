//
//  ProjectsViewModel.swift
//  SwitfWS
//
//  Created by gdaalumno on 04/12/24.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

@Observable class ProjectsViewModel {
    var project: [Project] = []
    var newProject = Project()
    var showNewProjectSheet = false
    
    var searching = ""
    var filteredProjects: [Project] {
        if searching.isEmpty {return self.project}
        return self.project.filter({$0.title.contains(searching)})
    }
    
    private let db = Firestore.firestore()
    
    private func addProjectToDb(_ project: Project, updateList: Bool = true) throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        try db.collection("users/" + user.uid + "/projects").document(project.id).setData(from: project)
        if updateList {
            self.project.append(project)
        }
        self.project.append(project)
        self.newProject = Project()
        self.showNewProjectSheet = false
    }
    
    private func fecthProjectsFromDb() async throws-> [Project] {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        let docuemntsQuery = try await  db.collection("users/\(user.uid)/projects").getDocuments()
        
        var _projects: [Project] = []
        
        for doc in docuemntsQuery.documents {
            let project = try doc.data(as: Project.self)
            _projects.append(project)
        }
        return _projects
    }
    
    private func deleteProjectFromDb(_ project: Project) throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.userAuthenticationRequired)
        }
        
        db.collection("users/\(user.uid)/projects").document(project.id).delete()
        self.project.removeAll(where: {$0.id == project.id})
    }
    
    public func removeProject(_ project: Project){
        do {
            try deleteProjectFromDb(project)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    public func downloadProjects() async {
        do {
            self.project = try await fecthProjectsFromDb()
        }catch {
            print(error.localizedDescription)
        }
    }
    
    public func uploadProject(updateList: Bool = true) {
        do {
            try addProjectToDb(self.newProject, updateList: updateList)
        } catch {
            print(error.localizedDescription)
        }
    }
}
