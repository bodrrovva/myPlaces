import UIKit
import MapboxMaps
import CoreLocation

class MapController: UIViewController {
    
    fileprivate var mapView: MapView!
    fileprivate var pinArray = [(55.756916, 37.633896), (55.752375, 37.644196), (55.755583, 37.615904)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addMap()
    }
    
    fileprivate func addMap() {
        mapView = MapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.mapboxMap.setCamera(to: CameraOptions(center: CLLocationCoordinate2D(latitude: 55.756916,longitude: 37.633896),zoom: 11.5))
        view.addSubview(mapView)

        let pinAnnnotationManager = mapView.annotations.makeCircleAnnotationManager()
        for (index, pin) in pinArray.enumerated() {
            let mapPin = CLLocationCoordinate2D(latitude: pin.0, longitude: pin.1)
            var pinAnnotation = CircleAnnotation(centerCoordinate: mapPin)
            pinAnnotation.circleColor = StyleColor(.blue)
            pinAnnotation.circleRadius = 7
            pinAnnotation.userInfo = ["id": index+1]
            pinAnnnotationManager.annotations.append(pinAnnotation)
        }
        pinAnnnotationManager.delegate = self
    }
}

extension MapController: AnnotationInteractionDelegate {
    func annotationManager(_ manager: AnnotationManager, didDetectTappedAnnotations annotations: [Annotation]) {
        let nextViewController = InfoVC()
        nextViewController.point = (annotations.first?.userInfo?["id"]) as! Int
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}

