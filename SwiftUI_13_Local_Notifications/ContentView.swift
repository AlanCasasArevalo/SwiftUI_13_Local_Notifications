
import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var show = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink (destination: LocalNotificationView(), isActive: self.$show) {
                    EmptyView()
                }
                Button(action: {
                    self.localNotification()
                }) {
                    Text("Notificacion")
                }
            }
            .onAppear {
                NotificationCenter.default.addObserver(forName: NSNotification.Name("OpenView"), object: nil, queue: .main) { notification in
                    // Accion del boton de la notificacion
                    self.show.toggle()
                }
            }
        }
    }
}

extension ContentView {
    func localNotification () {
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound, .carPlay, .announcement, .providesAppNotificationSettings]) { success, error in
            
        }
        
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
        
        if let attachmentImage = createImage() {
            content.attachments = [attachmentImage]
        }
        
        // Botones
        let openNewView = UNNotificationAction(identifier: "openNewView", title: "Abrir nueva vista", options: .foreground)
        let cancel = UNNotificationAction(identifier: "cancel", title: "Cancelar", options: .destructive)
        let category = UNNotificationCategory(identifier: "categoryActions", actions: [openNewView, cancel], intentIdentifiers: [])
        UNUserNotificationCenter.current().setNotificationCategories([category])
        
        content.categoryIdentifier = "categoryActions"
        
        return content
    }
    
    func createTrigger () -> UNTimeIntervalNotificationTrigger {
        // Disparador (triger)
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        return trigger
    }
    
    func createImage() -> UNNotificationAttachment? {
        // Imagen
        guard let imagePath = Bundle.main.path(forResource: "homer", ofType: "gif") else { return nil }
        let url = URL(fileURLWithPath: imagePath)
        
        do {
            let image = try UNNotificationAttachment(identifier: "homer", url: url, options: nil)
            return image
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
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
