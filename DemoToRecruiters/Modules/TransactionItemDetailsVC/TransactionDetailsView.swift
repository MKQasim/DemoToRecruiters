//
//  TransactionDetailsView.swift
//  DemoToRecruiters
//
//  Created by KamsQue on 29/01/2023.
//

import SwiftUI

struct TransactionDetailsView: View {
  
  let viewModel: DefaultTransactionDetailsViewModel
  weak var navigationController: UINavigationController?
  @SwiftUI.Environment(\.dismiss) var dismiss
  @State var animate = false
  
  init(viewModel: DefaultTransactionDetailsViewModel , navigationController :  UINavigationController) {
    self.viewModel = viewModel
    self.navigationController = navigationController
  }
  
  
  var body: some View {
    ZStack {
      CircleBackground(color: AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().firstCircleColor)
        .blur(radius: animate ? 30 : 100)
        .offset(x:animate ? -50 : -130,y:animate ? -30 : -100)
        .task {
          withAnimation(.easeInOut(duration: 7).repeatForever()){
            animate.toggle()
          }
        }
      CircleBackground(color: AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().secondCircleColor)
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
        Text("PayBack Test App")
          .font(.title)
          .foregroundColor(.white)
          .fontWeight(.bold )
        Text("\(viewModel.transactionDetailsModel?.partnerDisplayName ?? "")")
          .frame(maxWidth: 240)
          .font(.headline)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
        Text("\(Description(rawValue: viewModel.transactionDetailsModel?.transactionDetail?.description?.rawValue ?? "")?.rawValue ?? "")")
          .frame(maxWidth: 240)
          .font(.subheadline)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
        Text("\(viewModel.transactionDetailsModel?.transactionDetail?.bookingDate ?? Date())")
          .frame(maxWidth: 240)
          .font(.body)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
        Text("\(viewModel.transactionDetailsModel?.transactionDetail?.value?.amount ?? 0)  \("\(viewModel.transactionDetailsModel?.transactionDetail?.value?.currency?.rawValue ?? "")")")
          .frame(maxWidth: 240)
          .font(.body)
          .foregroundColor(.white)
          .multilineTextAlignment(.center)
        
      }
      .padding(.horizontal,20)
      .frame(maxWidth: .infinity,maxHeight: .infinity,alignment: .top)
    }
  
    .background(
      LinearGradient(gradient: Gradient(colors: AppColor.TransactionDetailsScreenColors.TransactionDetailsBackGroundView().backgroundGradiantColor), startPoint: .top, endPoint: .bottom))
  }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
      let vm = DefaultTransactionDetailsViewModel(transactionDetailsModel: Items(partnerDisplayName: "",category: 1))
      TransactionDetailsView(viewModel: vm, navigationController: UINavigationController())
    }
}

