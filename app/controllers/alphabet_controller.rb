class AlphabetController < UIViewController
  def viewDidLoad
    super
    self.title = 'Alphabet'
    @table = UITableView.alloc.initWithFrame(self.view.bounds)
    @table.autoresizingMask = UIViewAutoresizingFlexibleHeight
    @table.dataSource = self
    @table.delegate = self
    @data = ('A'...'Z').to_a
    self.view.addSubview(@table)
  end

  def tableView(tableView, numberOfRowsInSection: section)
    @data.count
  end

  def tableView(tableView, cellForRowAtIndexPath: indexPath)
    @reuseIdentifier ||= 'CELL_IDENTIFIER'
    cell = tableView.dequeueReusableCellWithIdentifier(@reuseIdentifier)
    cell ||= UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier: @reuseIdentifier)
    cell.textLabel.text = @data[indexPath.row]
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)
    tableView.deselectRowAtIndexPath(indexPath, animated: true)
    letter = @data[indexPath.row]
    controller = create_letter_viewcontroller(letter)
    self.navigationController.pushViewController(controller, animated: true)
  end

  def create_letter_viewcontroller(letter)
    controller = UIViewController.alloc.initWithNibName(nil, bundle: nil)
    controller.view.backgroundColor = UIColor.whiteColor
    controller.title = letter
    label = create_letter_label(controller, letter)
    controller.view.addSubview(label)
    controller
  end

  def create_letter_label(controller, letter)
    label = UILabel.alloc.initWithFrame CGRectZero
    label.text = letter
    label.sizeToFit
    label.center = [controller.view.frame.size.width / 2,
                    controller.view.frame.size.height / 2]
    label
  end
end