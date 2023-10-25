//
//  GrewEditView.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import SwiftUI

struct GrewEditView: View {
    @EnvironmentObject var viewModel: GrewViewModel

    @State var image: UIImage?
    @State var isAddress: Bool = false
    
    @State var isShowingAlert: Bool = false
    @State var isShowingSheet: Bool = false
    @State var isSelectedLocations: [Bool] = [false, false]
    @State var isSelectedFees: [Bool] = [false, false]
    
    @State var grewNameErrorMessage: String = ""
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("그루 수정")
                    .font(.b1_B)
                    .foregroundStyle(Color.Black)
                Spacer()
                Button(action: {
                    viewModel.showingSheet = false
                }, label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 24))
                        .foregroundStyle(Color.Black)
                })
                .frame(width: 32, height: 32)
            }.frame(height: 60)
            ScrollView {
                VStack {
                    Group {
                        HStack {
                            Text("그루명")
                                .font(.b2_R)
                                .foregroundStyle(Color.Black)
                            Spacer()
                        }
                        VStack {
                            DefaultTextField(placeholder: "그루명을 입력해주세요.", text: $viewModel.editGrew.title)
                            HStack {
                                Spacer()
                                Text(grewNameErrorMessage)
                                    .font(.c2_L)
                            }
                        }
                        Spacer(minLength: 10)
                    }
                    VStack {
                        HStack {
                            HStack {
                                Image("gender")
                                    .resizable()
                                    .frame(width: 24, height: 24)
                                Text("성별")
                                    .font(.b2_R)
                                    .foregroundStyle(Color.Black)
                            }
                            Spacer()
                            GrewGenderButtonsView(selectedGender: $viewModel.editGrew.gender)
                        }
                        HStack {
                            Spacer()
                            Text(grewNameErrorMessage)
                                .font(.c2_L)
                        }
                        Spacer(minLength: 10)
                    }
                    Group {
                        VStack {
                            HStack {
                                HStack {
                                    Image(systemName: "person.2.fill")
                                        .font(.system(size: 15))
                                    Text("최대 인원")
                                        .font(.b2_R)
                                }
                                Spacer()
                                DefaultTextField(placeholder: "최대 인원", text: $viewModel.editGrew.maximumMembers)
                            }
                            HStack {
                                Spacer()
                                Text(grewNameErrorMessage)
                                    .font(.c2_L)
                            }
                        }
                        Spacer(minLength: 10)
                    }
                    Group {
                        VStack {
                            HStack {
                                HStack {
                                    Image("age")
                                        .font(.system(size: 15))
                                    Text("나이 제한")
                                        .font(.b2_R)
                                }
                                Spacer()
                                DefaultTextField(placeholder: "최소 나이", text: $viewModel.editGrew.minimumAge)
                                DefaultTextField(placeholder: "최대 나이", text: $viewModel.editGrew.maximumAge)
                            }
                            HStack {
                                Spacer()
                                Text(grewNameErrorMessage)
                                    .font(.c2_L)
                            }
                        }
                        Spacer(minLength: 10)
                    }
                    Group {
                        VStack {
                            HStack {
                                Text("위치")
                                    .font(.b2_R)
                                    .foregroundStyle(Color.Black)
                                Spacer()
                                DefaultSelectedButton(isSelected: $isSelectedLocations[0], action: {
                                    selectLocation(.offline)
                                }, text: "오프라인")
                                DefaultSelectedButton(isSelected: $isSelectedLocations[1], action: {
                                    selectLocation(.online)
                                }, text: "온라인")
                            }
                            DefaultClickButton(action: {
                                isAddress = true
                                isShowingSheet = true
                            }, text: .constant("주소 검색"), isDisabled: $isSelectedLocations[0], placeholder: "주소 검색")
                            HStack {
                                Spacer()
                                Text(grewNameErrorMessage)
                                    .font(.c2_L)
                            }
                        }
                        Spacer(minLength: 10)
                    }
                    Group {
                        VStack {
                            HStack {
                                Text("활동비")
                                    .font(.b2_R)
                                    .foregroundStyle(Color.Black)
                                Spacer()
                                DefaultSelectedButton(isSelected: $isSelectedFees[0], action: {
                                    selectFee(.exist)
                                }, text: "있음")
                                DefaultSelectedButton(isSelected: $isSelectedFees[1], action: {
                                    selectFee(.free)
                                }, text: "없음")
                            }
                            DefaultTextField(placeholder: "활동비를 입력해주세요.", text: $viewModel.editGrew.fee)
                            HStack {
                                Spacer()
                                Text(grewNameErrorMessage)
                                    .font(.c2_L)
                            }
                        }
                        Spacer(minLength: 10)
                    }
                    Group {
                        VStack {
                            HStack {
                                Text("그루 설명")
                                    .font(.b2_R)
                                    .foregroundStyle(Color.Black)
                                Spacer()
                            }
                            DefaultTextField(height: 240, placeholder: "그루에 대해 자세하게 알려주세요.", text: $viewModel.editGrew.description)
                        }
                        HStack {
                            Spacer()
                            Text(grewNameErrorMessage)
                                .font(.c2_L)
                        }
                        Spacer(minLength: 10)
                    }
                    Group {
                        VStack {
                            HStack {
                                Text("그루 배경 이미지")
                                    .font(.b2_R)
                                    .foregroundStyle(Color.Black)
                                Spacer()
                            }
                            DefaultPlusButton(action: {
                                isAddress = false
                                isShowingSheet = true
                            }, text: "+ 사진 변경하기")
                            AsyncImage(url: URL(string: viewModel.editGrew.imageURL), content: { image in
                                image
                                    .resizable()
                            }, placeholder: {
                                ProgressView()
                            })
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .frame(height: 140)
                        }
                        Spacer(minLength: 80)
                    }
                    Group {
                        DefaultMainButton(action: {
                            viewModel.updateGrew() {
                                isShowingAlert = true
                            }
                        }, text: "수정 완료")
                        Spacer(minLength: 40)
                    }
                }.padding()
                    .onTapGesture(perform: {
                        self.endTextEditing()
                    })
            }
            .modifier(
                GrewAlertModifier(
                    isPresented: $isShowingAlert,
                    title: "수정이 완료되었습니다!",
                    buttonTitle: "확인",
                    buttonColor: .Main,
                    action: {
                        viewModel.showingSheet = false
                    },
                    secondButtonTitle: nil,
                    secondButtonColor: nil,
                    secondButtonAction: nil
                )
            )
            .onAppear(perform: {
                viewModel.makeEditGrew()
                self.isSelectedLocations[viewModel.editGrew.isOnline.locationIndex] = true
                self.isSelectedFees[viewModel.editGrew.isNeedFee.feeIndex] = true
            })
            .sheet(isPresented: $isShowingSheet, content: {
                ZStack{
                    if isAddress {
                        WebView(
                            request: URLRequest(url: URL(string: "https://da-hye0.github.io/Kakao-Postcode/")!),
                            showingWebSheet: $isShowingSheet,
                            location: $viewModel.editGrew.location,
                            latitude: $viewModel.editGrew.latitude,
                            longitude: $viewModel.editGrew.longitude
                        )
                        .padding(.top, 25)
                    } else {
                        ImagePicker(imageString: $viewModel.editGrew.imageURL, image: $image)
                    }
                }
                .presentationDetents([.large])
                .presentationDragIndicator(.visible)
            })
            .navigationBarBackButtonHidden()
        }
    }
    
    private func selectLocation(_ location: OnOff) {
        for index in 0..<isSelectedLocations.count {
            isSelectedLocations[index] = false
        }
        
        switch location {
        case .offline:
            isSelectedLocations[0] = true
        case .online:
            isSelectedLocations[1] = true
        }
    }
    
    private func selectFee(_ fee: Fee) {
        for index in 0..<isSelectedFees.count {
            isSelectedFees[index] = false
        }
        
        switch fee {
        case .exist:
            isSelectedFees[0] = true
        case .free:
            isSelectedFees[1] = true
        }
    }
}

#Preview {
    GrewEditView()
}
