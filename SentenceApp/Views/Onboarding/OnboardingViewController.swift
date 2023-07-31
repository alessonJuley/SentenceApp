//
//  OnboardingViewController.swift
//  SentenceApp
//
//  Created by Alesson Abao on 21/06/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    // MARK: Outlets
    @IBOutlet weak var OnboardingImages: UICollectionView!
    @IBOutlet weak var onboardingButton: UIButton!
    @IBOutlet weak var onboardingPageControl: UIPageControl!
    
    var imageSlides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            if currentPage == imageSlides.count - 1{
                onboardingButton.setTitle("Get Started", for: .normal)
            }
            else{
                onboardingButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageSlides = [
            OnboardingSlide(title: "563.786 GDICT Industry Project", description: "This is a project requirement for GDICT Industry Project.", image: UIImage(named: "Slide1") ?? UIImage()),
            OnboardingSlide(title: "Made by Alesson Abao", description: "This project used the big bang model due to it being ideal for small projects and commonly applied to projects for learning or experimental purposes.", image: UIImage(named: "Slide2") ?? UIImage()),
            OnboardingSlide(title: "Dummy Data", description: "The student created the dataset with dummy data. Sentences may not reflect real-life outputs.", image: UIImage(named: "Slide3") ?? UIImage())
        ]
    }
    
    @IBAction func actionButton(_ sender: UIButton) {
        
        if currentPage == imageSlides.count - 1{
            let controller = storyboard?.instantiateViewController(withIdentifier: "HomeNC") as! UINavigationController
            controller.modalPresentationStyle = .fullScreen
            controller.modalTransitionStyle = .flipHorizontal
            present(controller, animated: true, completion: nil)
        }
        else{
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            OnboardingImages.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true )
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageSlides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        
        cell.setUp(imageSlides[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    // when scolling is finished
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        
        // update page control
        onboardingPageControl.currentPage = currentPage
    }
}
