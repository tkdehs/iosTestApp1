//
//  HomeViewController.swift
//  iosTestApp1
//
//  Created by PNX on 2022/03/04.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    let sectiontitles:[String] = ["Trending Movies" ,"Trending Tv" ,"Popular", "Upcoming Movies", "Top rated"]

    private let homeFeedTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        headerView?.delegate = self
        homeFeedTable.tableHeaderView = headerView
        confiureHeroHeaderView()
        configureNavbar()
        
    }
    
    private func confiureHeroHeaderView(){
        APICaller.shared.getTrendingTvs { [weak self] result in
            switch result {
            case .success(let titles):
                guard let selectedTitle = titles.randomElement() else {return}

                self?.randomTrendingMovie = selectedTitle
                self?.headerView?.configure(with: selectedTitle)
            case .failure(let error):
                DLog(error.localizedDescription)
            }
        }
    }
    
    func configureNavbar(){
        var image = UIImage(named: "netflix_logo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController:UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectiontitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in
                switch results {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        case Sections.TrendingTv.rawValue:
            APICaller.shared.getTrendingTvs { results in
                switch results {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        case Sections.Popular.rawValue:
            APICaller.shared.getPopular { results in
                switch results {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        case Sections.Upcoming.rawValue:
            APICaller.shared.getUpcomingMovies { results in
                switch results {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        case Sections.TopRated.rawValue:
            APICaller.shared.getTopRated { results in
                switch results {
                case .success(let titles):
                    cell.configure(with: titles)
                case .failure(let error):
                    DLog(error.localizedDescription)
                }
            }
        default:
            return UITableViewCell()
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func  tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectiontitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        // 테이블 뷰가 스크롤 될 때 상단 네비게이션 위치 컨트롤
        // 올릴떄는 같이 올라가고
        // 내려갈 때 맨위라면 땅겨지지 않도록
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HomeViewController: HeroHeaderUIViewDelegate {
    func heroHeaderUIViewPlayTarget(model: TitlePreviewViewModel) {
        let vc = TitlePreviewViewController()
        vc.configure(with: model)
        navigationController?.pushViewController(vc, animated: true)
    }
}
