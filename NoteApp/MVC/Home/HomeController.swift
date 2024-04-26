protocol HomeControllerProtocol: AnyObject {
    
}
class HomeController: HomeModelProtocol {
    var view: HomeViewProtocol?
    var model: HomeModelProtocol?
    
    init(view: HomeViewProtocol?) {
        self.view = view
        self.model = HomeModel(controller: self)
    }
    
}
extension HomeController: HomeControllerProtocol{
    
    
}

