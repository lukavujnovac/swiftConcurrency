//
//  ContentView.swift
//  SwiftConcurrency
//
//  Created by Luka Vujnovac on 27.04.2022..
//

import SwiftUI

struct ContentView: View {
    @State var isExpanding = false
    @State var activeID = UUID()
    
    var body: some View {
        ZStack{
            Color(self.isExpanding ? UIColor.systemGray2 : .white)
                .edgesIgnoringSafeArea(.all)
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 0){
                    Text("Wednesday, April 27")
                    HStack{
                        Text("Today")
                            .font(.system(.title))
                            .fontWeight(.semibold)
                        Spacer()
                        Image(systemName: "person.circle")
                            .resizable()
                            .frame(width: 35, height: 35)
                    }
                }.padding()
                    .opacity(self.isExpanding ? 0 : 1)
                
                VStack(spacing: 30) {
                    ForEach(items) {item in
                        GeometryReader { proxy in 
                            ExpandingView(isExpanding: $isExpanding, activeID: $activeID, data: item)
                                .offset(y: self.activeID == item.id ? -proxy.frame(in: .global).minY : 0)
                                .opacity(self.activeID != item.id && self.isExpanding ? 0 : 1)
                        } .frame(height: Screen.height * 0.45)
                            .frame(maxWidth: self.isExpanding ? Screen.width : Screen.width * 0.9)
                    }
                }
            } 
        }
        
    }
    @State var items = [
        Item(title: "neki malo duzi title da vidin kako se scale", subtitle: "neki subtitle", image: "img3", content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur?"),
        Item(title: "neki title", subtitle: "neki subtitle", image: "img1", content: "neki tekst da popuni ovo sve ode kjdhsfglkjsdhfjksgljkhafslkjfhdksjhgjklsadhgljkdshfkljadhsfkjlhsdkjlfhsdkjlfhkjsdlhfjksdhfkjdlshfkljdshflkjdshfkshdfkjlasdhflkdhj"),
        Item(title: "neki title", subtitle: "neki subtitle", image: "img2", content: "neki tekst da popuni ovo sve ode kjdhsfglkjsdhfjksgljkhafslkjfhdksjhgjklsadhgljkdshfkljadhsfkjlhsdkjlfhsdkjlfhkjsdlhfjksdhfkjdlshfkljdshflkjdshfkshdfkjlasdhflkdhj"),
        Item(title: "neki title", subtitle: "neki subtitle", image: "img3", content: "neki tekst da popuni ovo sve ode kjdhsfglkjsdhfjksgljkhafslkjfhdksjhgjklsadhgljkdshfkljadhsfkjlhsdkjlfhsdkjlfhkjsdlhfjksdhfkjdlshfkljdshflkjdshfkshdfkjlasdhflkdhj"),
        Item(title: "neki title", subtitle: "neki subtitle", image: "img1", content: "neki tekst da popuni ovo sve ode kjdhsfglkjsdhfjksgljkhafslkjfhdksjhgjklsadhgljkdshfkljadhsfkjlhsdkjlfhsdkjlfhkjsdlhfjksdhfkjdlshfkljdshflkjdshfkshdfkjlasdhflkdhj"),
        Item(title: "neki title", subtitle: "neki subtitle", image: "img3", content: "neki tekst da popuni ovo sve ode kjdhsfglkjsdhfjksgljkhafslkjfhdksjhgjklsadhgljkdshfkljadhsfkjlhsdkjlfhsdkjlfhkjsdlhfjksdhfkjdlshfkljdshflkjdshfkshdfkjlasdhflkdhj"),
        Item(title: "neki title", subtitle: "neki subtitle", image: "img2", content: "neki tekst da popuni ovo sve ode kjdhsfglkjsdhfjksgljkhafslkjfhdksjhgjklsadhgljkdshfkljadhsfkjlhsdkjlfhsdkjlfhkjsdlhfjksdhfkjdlshfkljdshflkjdshfkshdfkjlasdhflkdhj")
    ]
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInterfaceOrientation(.portrait)
    }
}

struct ExpandingView: View {
    @State var dragValue = CGSize.zero
    @Binding var isExpanding: Bool
    @Binding var activeID: UUID
    
    var data: Item
    
    var body: some View {
        ZStack(alignment: .top){
            Image(data.image)
                .resizable()
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .shadow(radius: 5)
                .onTapGesture {
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.6)) {
                        self.isExpanding = true
                        self.activeID = self.data.id
                    }
                }
                .opacity(self.activeID == data.id ? 0 : 1)
            
            //title section
            HStack{
                VStack(alignment: .leading, spacing: 0) {
                    Text(data.subtitle)
                        .foregroundColor(Color(uiColor: .systemBackground))
                        .fontWeight(.semibold)
                    Text(data.title)
                        .font(.system(.title))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                .padding(.vertical, 5)
                .padding(.horizontal, 15)
                .background(Color.black.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
            }.padding()
            .opacity(self.activeID == data.id ? 0 : 1)
            
            ZStack{
                Color.white.edgesIgnoringSafeArea(.all)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(alignment: .leading){
                            Image(data.image)
                                .resizable()
                                .frame(maxHeight: Screen.height * 0.45)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .padding(.bottom)
                            
                            Text(data.title)
                                .font(.system(.title))
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .multilineTextAlignment(.leading)
                                .padding(.bottom, 5)
                            
                            Text(data.content)
                                .foregroundColor(.black)
                                .padding(.horizontal)
                                .padding(.bottom)
                                .multilineTextAlignment(.leading)
                        }.padding(.bottom)
                }.edgesIgnoringSafeArea(.all)
                
                VStack{
                    HStack{
                        Spacer()
                        
                        Button { 
                            withAnimation(.spring(response: 0.6, dampingFraction: 0.8, blendDuration: 0.6)) {
                                self.isExpanding = false
                                self.activeID = UUID()
                            }
                        } label: { 
                            Image(systemName: "xmark")
                                .foregroundColor(Color.white.opacity(0.2))
                        }.frame(width: 30, height: 30)
                            .background(
                                Circle()
                                    .foregroundColor(Color.white.opacity(0.6))
                            )
                    }.padding(.top, 30)
                    Spacer()
                }.padding()
            }.opacity(self.activeID == data.id ? 1 : 0)
        }
        .frame(height: self.activeID == self.data.id ? Screen.height : Screen.height * 0.45)
        .edgesIgnoringSafeArea(.all)
    }
}

struct Item: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var image: String
    var content: String
}

struct Screen {
    static let height = UIScreen.main.bounds.height
    static let width = UIScreen.main.bounds.width
}

struct TemporaryView: View {
    
    
    var body: some View {
        Text("Holder")
    }
}
