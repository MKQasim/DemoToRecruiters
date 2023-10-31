//
//  UserDetailsView.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import SwiftUI

struct UserDetailsView: View {
  
  let viewModel: DefaultUserDetailsViewModel
  weak var navigationController: UINavigationController?
  @SwiftUI.Environment(\.dismiss) var dismiss
  @State var animate = false
  
  init(viewModel: DefaultUserDetailsViewModel , navigationController :  UINavigationController) {
    self.viewModel = viewModel
    self.navigationController = navigationController
  }
  
  
  var body: some View {
    ZStack {
      CircleBackground(color: AppColor.UserDetailsScreenColors.UserDetailsBackGroundView().firstCircleColor)
        .blur(radius: animate ? 30 : 100)
        .offset(x:animate ? -50 : -130,y:animate ? -30 : -100)
        .task {
          withAnimation(.easeInOut(duration: 7).repeatForever()){
            animate.toggle()
          }
        }
      CircleBackground(color: AppColor.UserDetailsScreenColors.UserDetailsBackGroundView().secondCircleColor)
        .blur(radius: animate ? 30:  100)
        .offset(x:animate ? 50 :130,y: animate ? 150:  100)
      VStack(spacing: 30.0) {
        HStack(spacing: 0.0){
          CircleButton(action: {
            dismiss()
          },image:ImageFactory.NavBar.arrowLeft)
          Spacer()
          CircleButton(action: {},image: ImageFactory.NavBar.ellipsis)
        }
        .padding(EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 20))
          Text("Test App")
          .font(.title)
          .foregroundColor(.white)
          .fontWeight(.bold )
          Text("\(viewModel.userDetailsModel?.name ?? "")")
          .frame(maxWidth: 240)
          .font(.headline)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          Text("\(viewModel.userDetailsModel?.email ?? "")")
          .frame(maxWidth: 240)
          .font(.subheadline)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          Text("\(viewModel.userDetailsModel?.company?.name ?? "" )")
          .frame(maxWidth: 240)
          .font(.body)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
          Text("\(viewModel.userDetailsModel?.name ?? "")  \("\(viewModel.userDetailsModel?.email ?? "")")")
          .frame(maxWidth: 240)
          .font(.body)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
        
      }
      .padding(.horizontal,20)
      .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
  
    .background(
      LinearGradient(gradient: Gradient(colors: AppColor.UserDetailsScreenColors.UserDetailsBackGroundView().backgroundGradiantColor), startPoint: .top, endPoint: .bottom))
  }
}

struct UserDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = DefaultUserDetailsViewModel(UserDetailsModel: User(id: 1, name: ""))
      UserDetailsView(viewModel: vm, navigationController: UINavigationController())
    }
}

