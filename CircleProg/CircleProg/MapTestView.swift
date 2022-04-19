//
//  MapTestView.swift
//  CircleProg
//
//  Created by Don Mag on 7/13/21.
//

import SwiftUI
import MapKit

struct MapTestView: View {
	@State private var region = MKCoordinateRegion(
		
		center: CLLocationCoordinate2D(
			
			latitude: 25.7617,
			
			longitude: 80.1918
			
		),
		
		span: MKCoordinateSpan(
			
			latitudeDelta: 10,
			
			longitudeDelta: 10
			
		)
		
	)

	var body: some View {
		
		VStack {
			
			Map(coordinateRegion: $region)
			
			
			
			Button("zoom") {
				
				withAnimation {
					
					region.span = MKCoordinateSpan(
						
						latitudeDelta: 100,
						
						longitudeDelta: 100
						
					)
					
				}
				
			}
			
			Button("test") {
				
				withAnimation {
						region.span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
						region.center = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)
//					region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
				}

			}
			
			Button(action: {
				
				withAnimation {
					
					region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))
					
					
					
				}
				
			}) {
				
				Image(systemName: "location.fill")
					
					.frame(width: 44, height: 44, alignment: .center)
					
					.foregroundColor(.black)
					
					.background(Color(.white))
				
			}.buttonStyle(PlainButtonStyle())
			
			.clipShape(Circle())
			.shadow(color: Color.black.opacity(0.5), radius: 1.0, x: 0.0, y: 2.0)
			
		}
		
	}
	
}

struct MapTestView_Previews: PreviewProvider {
    static var previews: some View {
        MapTestView()
    }
}
