import UIKit

// MARK: - Model
struct InsightItem {
    let title: String
    let text: String
}

// MARK: - Cell
final class InsightCell: UICollectionViewCell {
    static let reuseId = "InsightCell"

    let container: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 14
        v.layer.shadowColor = UIColor.black.cgColor
        v.layer.shadowOpacity = 0.08
        v.layer.shadowOffset = CGSize(width: 0, height: 2)
        v.layer.shadowRadius = 6
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    let titleLabel = UILabel()
    let bodyLabel = UILabel()
    let shareButton = UIButton(type: .system)
    let saveButton = UIButton(type: .system)

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .clear

        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        bodyLabel.font = .systemFont(ofSize: 14)
        bodyLabel.numberOfLines = 4
        bodyLabel.textColor = UIColor(hexString: "#7A7A7A")
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false

        shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        shareButton.tintColor = .black
        shareButton.translatesAutoresizingMaskIntoConstraints = false

        saveButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        saveButton.tintColor = .black
        saveButton.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(container)
        container.addSubview(titleLabel)
        container.addSubview(bodyLabel)
        container.addSubview(shareButton)
        container.addSubview(saveButton)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

            saveButton.topAnchor.constraint(equalTo: container.topAnchor, constant: 12),
            saveButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -12),

            shareButton.centerYAnchor.constraint(equalTo: saveButton.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: saveButton.leadingAnchor, constant: -12),

            titleLabel.topAnchor.constraint(equalTo: saveButton.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            bodyLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 14),
            bodyLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -14),
            bodyLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -14)
        ])
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with item: InsightItem) {
        titleLabel.text = item.title
        bodyLabel.text = item.text
    }
}



// MARK: - Insights ViewController
class InsightsViewController: UIViewController {

    // MARK: Data
    private let warnings: [InsightItem] = [
        InsightItem(title: "Warning Signs to Notice", text: "Any heavy bleeding or severe cramps should not be ignored zzzzzzzzzzzzzzzzzzxxcccvvvvvbbbbnnnmnmmmkklllklkkjjjjhhhggggffffddddssssaaqqwweerrttyyuuioop..."),
        InsightItem(title: "High Fever", text: "A fever above 101°F may indicate infection."),
        InsightItem(title: "Severe Headache", text: "Unusual headaches may mean preeclampsia...")
    ]

    private let myths: [InsightItem] = [
        InsightItem(title: "Mango Causes Miscarriage (Myth)", text: "No scientific evidence supports this."),
        InsightItem(title: "Avoid Exercise (Myth)", text: "Light exercise is safe and recommended."),
        InsightItem(title: "Cold Weather Hurts Baby (Myth)", text: "Temperature doesn’t affect baby health.")
    ]

    private var warningCollection: UICollectionView!
    private var mythCollection: UICollectionView!

    private var warningIndex = 0
    private var mythIndex = 0

    private var itemWidth: CGFloat { view.bounds.width * 0.72 }
    private let itemHeight: CGFloat = 260

    private let warningTitle = UILabel()
    private let mythTitle = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupTitles()
        setupWarningCarousel()
        setupMythCarousel()
    }


    // MARK: Titles
    private func setupTitles() {
        warningTitle.text = "Warning"
        warningTitle.font = .boldSystemFont(ofSize: 22)
        warningTitle.translatesAutoresizingMaskIntoConstraints = false

        mythTitle.text = "Myths"
        mythTitle.font = .boldSystemFont(ofSize: 22)
        mythTitle.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(warningTitle)
        view.addSubview(mythTitle)

        NSLayoutConstraint.activate([
            warningTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            warningTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }


    // MARK: Warning Carousel
    private func setupWarningCarousel() {
        warningCollection = buildCarousel()
        view.addSubview(warningCollection)

        NSLayoutConstraint.activate([
            warningCollection.topAnchor.constraint(equalTo: warningTitle.bottomAnchor, constant: 12),
            warningCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            warningCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            warningCollection.heightAnchor.constraint(equalToConstant: itemHeight)
        ])

        // Position myth title
        NSLayoutConstraint.activate([
            mythTitle.topAnchor.constraint(equalTo: warningCollection.bottomAnchor, constant: 35),
            mythTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }


    // MARK: Myth Carousel
    private func setupMythCarousel() {
        mythCollection = buildCarousel()
        view.addSubview(mythCollection)

        NSLayoutConstraint.activate([
            mythCollection.topAnchor.constraint(equalTo: mythTitle.bottomAnchor, constant: 12),
            mythCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mythCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mythCollection.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
    }


    // MARK: Build Carousel
    private func buildCarousel() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 16

        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(InsightCell.self, forCellWithReuseIdentifier: InsightCell.reuseId)
        cv.showsHorizontalScrollIndicator = false
        cv.decelerationRate = .fast
        cv.dataSource = self
        cv.delegate = self
        cv.clipsToBounds = false
        return cv
    }
}


// MARK: - DataSource + Delegate
extension InsightsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    private func dataset(for collection: UICollectionView) -> [InsightItem] {
        return (collection === warningCollection) ? warnings : myths
    }

    private func index(for collection: UICollectionView) -> Int {
        return (collection === warningCollection) ? warningIndex : mythIndex
    }

    private func setIndex(for collection: UICollectionView, to new: Int) {
        if collection === warningCollection { warningIndex = new }
        else { mythIndex = new }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataset(for: collectionView).count
    }

    func collectionView(_ c: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = c.dequeueReusableCell(withReuseIdentifier: InsightCell.reuseId, for: indexPath) as! InsightCell
        cell.configure(with: dataset(for: c)[indexPath.item])
        applyScale(to: cell, in: c, at: indexPath)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemWidth, height: itemHeight)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let cv = scrollView as? UICollectionView else { return }
        for cell in cv.visibleCells {
            if let idx = cv.indexPath(for: cell),
               let c = cell as? InsightCell {
                applyScale(to: c, in: cv, at: idx)
            }
        }
    }

    private func applyScale(to cell: InsightCell, in cv: UICollectionView, at indexPath: IndexPath) {
        guard let attr = cv.layoutAttributesForItem(at: indexPath) else { return }

        let center = cv.bounds.width / 2
        let offsetCenter = cv.contentOffset.x + center
        let distance = abs(attr.center.x - offsetCenter)

        let maxDistance = center + attr.bounds.width
        let ratio = max(0, 1 - distance / maxDistance)

        let scale = 0.85 + (0.15 * ratio)
        let alpha = 0.2 + (0.6 * ratio)

        cell.transform = CGAffineTransform(scaleX: scale, y: scale)
        cell.alpha = alpha
    }

    func scrollViewWillEndDragging(
        _ scrollView: UIScrollView,
        withVelocity velocity: CGPoint,
        targetContentOffset: UnsafeMutablePointer<CGPoint>
    ) {
        guard let cv = scrollView as? UICollectionView else { return }

        let data = dataset(for: cv)
        var bestIndex = 0
        var bestDist = CGFloat.greatestFiniteMagnitude

        let midX = targetContentOffset.pointee.x + cv.bounds.width / 2

        for i in 0..<data.count {
            if let attr = cv.layoutAttributesForItem(at: IndexPath(item: i, section: 0)) {
                let d = abs(attr.center.x - midX)
                if d < bestDist { bestDist = d; bestIndex = i }
            }
        }

        if let attr = cv.layoutAttributesForItem(at: IndexPath(item: bestIndex, section: 0)) {
            targetContentOffset.pointee.x = attr.center.x - cv.bounds.width / 2
        }

        setIndex(for: cv, to: bestIndex)
    }
}


// MARK: - Hex Color
extension UIColor {
    convenience init(hexString: String) {
        var hex = hexString.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgb)
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: 1
        )
    }
}
