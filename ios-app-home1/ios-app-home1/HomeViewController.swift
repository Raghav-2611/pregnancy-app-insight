import UIKit

class HomeViewController: UIViewController {

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let headerView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let circleView: UIView = {
        let v = UIView()
        v.layer.cornerRadius = 70
        v.layer.borderWidth = 2
        v.layer.borderColor = UIColor.white.cgColor
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    private let weekLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "WEEK"
        lbl.font = .systemFont(ofSize: 12, weight: .medium)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let weekNumberLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "7"
        lbl.font = .systemFont(ofSize: 40, weight: .bold)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    private let dayLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "+3 day"
        lbl.font = .systemFont(ofSize: 14)
        lbl.textColor = .white
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    func createCard(title: String, image: UIImage?) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 12
        button.backgroundColor = UIColor(hex: "#FF7E95")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true

        let label = UILabel()
        label.text = title
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false

        let imgView = UIImageView(image: image)
        imgView.contentMode = .scaleAspectFit
        imgView.translatesAutoresizingMaskIntoConstraints = false

        button.addSubview(label)
        button.addSubview(imgView)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 16),
            label.centerYAnchor.constraint(equalTo: button.centerYAnchor),

            imgView.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -16),
            imgView.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            imgView.widthAnchor.constraint(equalToConstant: 90),
            imgView.heightAnchor.constraint(equalToConstant: 90)
        ])

        return button
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        setupScrollView()
        setupHeader()
        setupCards()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        applyCurvedMask()
    }

    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setupHeader() {
        contentView.addSubview(headerView)

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 260)
        ])

        applyGradient()

        headerView.addSubview(circleView)
        circleView.addSubview(weekLabel)
        circleView.addSubview(weekNumberLabel)
        circleView.addSubview(dayLabel)

        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor, constant: 10),
            circleView.heightAnchor.constraint(equalToConstant: 140),
            circleView.widthAnchor.constraint(equalToConstant: 140),

            weekLabel.topAnchor.constraint(equalTo: circleView.topAnchor, constant: 28),
            weekLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),

            weekNumberLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            weekNumberLabel.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),

            dayLabel.topAnchor.constraint(equalTo: weekNumberLabel.bottomAnchor, constant: 5),
            dayLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor)
        ])
    }

    func applyGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 260)
        gradient.colors = [
            UIColor(hex: "#FFBFBC").cgColor,
            UIColor(hex: "#FF7E95").cgColor
        ]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        headerView.layer.insertSublayer(gradient, at: 0)
    }

    // MARK: Curve Mask
    func applyCurvedMask() {
        let width = headerView.bounds.width
        let height = headerView.bounds.height
        let curveDepth: CGFloat = 18

        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: height - curveDepth))

        path.addCurve(
            to: CGPoint(x: width, y: height - curveDepth),
            controlPoint1: CGPoint(x: width * 0.30, y: height + curveDepth * 0.8),
            controlPoint2: CGPoint(x: width * 0.70, y: height + curveDepth * 0.8)
        )

        path.addLine(to: CGPoint(x: width, y: 0))
        path.close()

        let mask = CAShapeLayer()
        mask.path = path.cgPath
        headerView.layer.mask = mask
    }

    // MARK: Cards
    func setupCards() {
        let card1 = createCard(title: "Calendar", image: UIImage(named: "calendar"))
        let card2 = createCard(title: "Mother health\n& tracking tools", image: UIImage(named: "mom"))
        let card3 = createCard(title: "To-Do", image: UIImage(named: "todo"))

        // BUTTON ACTIONS
        card1.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
        card2.addTarget(self, action: #selector(openMotherTools), for: .touchUpInside)
        card3.addTarget(self, action: #selector(openToDo), for: .touchUpInside)

        contentView.addSubview(card1)
        contentView.addSubview(card2)
        contentView.addSubview(card3)

        NSLayoutConstraint.activate([
            card1.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            card1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            card1.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            card1.heightAnchor.constraint(equalToConstant: 120),

            card2.topAnchor.constraint(equalTo: card1.bottomAnchor, constant: 16),
            card2.leadingAnchor.constraint(equalTo: card1.leadingAnchor),
            card2.trailingAnchor.constraint(equalTo: card1.trailingAnchor),
            card2.heightAnchor.constraint(equalToConstant: 120),

            card3.topAnchor.constraint(equalTo: card2.bottomAnchor, constant: 16),
            card3.leadingAnchor.constraint(equalTo: card1.leadingAnchor),
            card3.trailingAnchor.constraint(equalTo: card1.trailingAnchor),
            card3.heightAnchor.constraint(equalToConstant: 120),

            card3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    // MARK: Card Button Actions
    @objc func openCalendar() {
        print("Calendar clicked")
    }

    @objc func openMotherTools() {
        print("Mother tools clicked")
    }

    @objc func openToDo() {
        print("To-Do clicked")
    }
}


// MARK: - HEX COLOR EXTENSION
extension UIColor {
    convenience init(hex: String) {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if hexString.hasPrefix("#") { hexString.removeFirst() }

        var rgb: UInt64 = 0
        Scanner(string: hexString).scanHexInt64(&rgb)

        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255,
            blue: CGFloat(rgb & 0x0000FF) / 255,
            alpha: 1.0
        )
    }
}
