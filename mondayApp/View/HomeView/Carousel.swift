import SwiftUI

struct CarouselView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var filterViewModel: FilterViewModel
    
    var body: some View {
        ZStack {
            HStack {
                ForEach(filtersToShow(filterViewModel.GetActivatedFilter(),filterViewModel: filterViewModel), id: \.self) {filterName in
                    Group {
                        Button(action: {
                            withAnimation {
                                if self.filterViewModel.GetActivatedFilter() != filterName{
                                    switch(filterName){
                                    case FILTERS.EVERYONE:
                                        self.homeViewModel.savedPopularPosition = self.homeViewModel.currentPost
                                        print("switching to everyone")
                                    case FILTERS.POPULAR:
                                        if self.filterViewModel.GetActivatedFilter() == FILTERS.EVERYONE{
                                            self.homeViewModel.savedEveryonePosition = self.homeViewModel.currentPost
                                        }else{
                                            self.homeViewModel.savedForYouPosition = self.homeViewModel.currentPost
                                        }
                                        print("switching to popular")
                                    case FILTERS.FORYOU:
                                        self.homeViewModel.savedPopularPosition = self.homeViewModel.currentPost
                                        print("switching to for you")
                                    default:
                                        return
                                    }
                                    self.filterViewModel.SetActivatedFilter(filter: filterName)
                                    self.homeViewModel.resetPostPos()
                                    HomeViewModel.loadNewFeed(homeViewModel: self.homeViewModel, filterViewModel: self.filterViewModel, newFilter: self.filterViewModel.GetActivatedFilter(), fromCarousel: true)
                                }else{
                                    self.homeViewModel.currentPost = 0
                                }
                            }
                        }) {
                            CarouselItem(filterName: filterName, isSelectedFilter: filterName == self.filterViewModel.GetActivatedFilter(),filterViewModel: self.filterViewModel)
                        }
                        if filterName != filtersToShow(self.filterViewModel.GetActivatedFilter(),filterViewModel:self.filterViewModel).last {
                            Spacer()
                        }
                    }
                }
                .foregroundColor(.white)
                
            }
        }
    }
}

struct CarouselItem: View {
    let filterName: FILTERS
    let isSelectedFilter: Bool
    var filterViewModel: FilterViewModel
    var body: some View {
        HStack {
            Text(filterName.rawValue)
                .fontWeight(isSelectedFilter ? .black : .medium)
                .font(isSelectedFilter ? .title : .body)
                .underline(isSelectedFilter ? true : false, color: Color.red)
                .padding(.horizontal, isSelectedFilter && selectedFilterInTheMiddle(filterName,filterViewModel: filterViewModel) ? 35 : 15)
                .animation(.spring(response: 0.0, dampingFraction: 0.2))
        }
    }
}

// MARK: -  Detecting previous and next array element

extension BidirectionalCollection where Iterator.Element: Equatable {
    typealias Element = Self.Iterator.Element
    
    func after(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let lastItem: Bool = (index(after:itemIndex) == endIndex)
            if loop && lastItem {
                return self.first
            } else if lastItem {
                return nil
            } else {
                return self[index(after:itemIndex)]
            }
        }
        return nil
    }
    
    func before(_ item: Element, loop: Bool = false) -> Element? {
        if let itemIndex = self.firstIndex(of: item) {
            let firstItem: Bool = (itemIndex == startIndex)
            if loop && firstItem {
                return self.last
            } else if firstItem {
                return nil
            } else {
                return self[index(before:itemIndex)]
            }
        }
        return nil
    }
}

func filtersToShow(_ x: FILTERS, filterViewModel: FilterViewModel) -> [FILTERS] {
    var array = [FILTERS]()
    if let beforeX = filterViewModel.GetAllFilters().before(x) {
        array.append(beforeX)
    }
    array.append(x)
    if let afterX = filterViewModel.GetAllFilters().after(x) {
        array.append(afterX)
    }
    
    return array
}

func selectedFilterInTheMiddle(_ x: FILTERS,filterViewModel: FilterViewModel) -> Bool {
    if x != filtersToShow(x,filterViewModel: filterViewModel).first {
        return false
    } else if x != filtersToShow(x,filterViewModel: filterViewModel).last {
        return false
    }
    return true
}
