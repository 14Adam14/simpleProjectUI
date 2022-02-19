

import SwiftUI


//



class ViewModel: ObservableObject {
    
    @Published var image: Image?
    
    
    func fetchNewImage() {
        guard let url = URL(string: "https://random.imagecdn.app/500/500") else {
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            
            DispatchQueue.main.async {
                guard let uiImage = UIImage(data: data) else {
                    return
                }
                self.image = Image(uiImage: uiImage)
                
            }
        }
        task.resume()
    }
}



struct ContentView: View {
    
   @StateObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                
                
                Text("pictha")
                    .font(.system(size: 40, weight: .semibold, design: .monospaced))
                   // .font(.largeTitle)
                   // .fontWeight(.semibold)
                
                
                Spacer()
                    
                
                if let image = viewModel.image {
                    ZStack{
                        image
                            .resizable()
                            .foregroundColor(Color.gray)
                            .frame(width: 300, height: 300)
                            .padding()
                            //.cornerRadius(8)
                    }
                    .frame(width: UIScreen.main.bounds.width / 1.2, height: UIScreen.main.bounds.width / 1.2)
                    .background(Color.gray)
                    .cornerRadius(8)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .foregroundColor(Color.gray)
                        .frame(width: 200, height: 200)
                        .padding()
                }
                
                Spacer()
                
                Button {
                    viewModel.fetchNewImage()
                } label: {
                    Text("New Image!")
                        .bold()
                        .frame(width: 250, height: 55)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding()
                }
               

                
            }
           
            
//            .navigationTitle("Photo Mania")
//            .navigationBarTitleDisplayMode(.inline)
            
            
            
            
        }
        
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
