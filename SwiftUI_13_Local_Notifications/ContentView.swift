
import SwiftUI
import UserNotifications

struct ContentView: View {

    var body: some View {

        VStack {
            Button(action: {
                self.localNotification()
            }) {
                Text("Notificacion")
            }
        }
        
    }
}

extension ContentView {
    func localNotification () {
                
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .carPlay, .announcement, .providesAppNotificationSettings]) { success, error in
            
        }
        
        // Imagen
        
        
        // Botones
                
        createRequest()
    }
    
    
    func createContent () -> UNMutableNotificationContent {
        // contenido
        let content = UNMutableNotificationContent()
        content.title = "Titulo de la noti"
        content.subtitle = "Subtitulo de la noti"
        content.body = "Este es el cuerpo de la notificacion es donde vendra todo el centro de la misma"
        content.sound = .defaultCritical
        content.badge = 1
        return content
    }
    
    func createTrigger () -> UNTimeIntervalNotificationTrigger {
        // Disparador (triger)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        return trigger
    }
    
    func createRequest () {
        let request = UNNotificationRequest(identifier: "noti", content: createContent(), trigger: createTrigger())
        UNUserNotificationCenter.current().add(request)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
