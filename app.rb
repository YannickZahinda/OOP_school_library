require './student'
require './teacher'
require './book'
require './rental'

class App
  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def show_menu
    puts "\n\nWelcome to School Library App!\n\n"
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts "7 - Exit\n\n"
    gets.chomp
  end

  def list_people
    puts 'List of people:'
    @people.each do |person, index|
      puts "#{index}) - Name: #{person.name} ID: #{person.id} Age: #{person.age}"
    end
  end

  def list_books
    puts 'List of books:'
    @books.each do |book, index|
      puts "(#{index}) - Author: #{book.author} Title: #{book.title}"
    end
  end

  def create_student
    puts 'Enter student name:'
    name = gets.chomp
    puts 'Enter student age:'
    age = gets.chomp.to_i
    puts 'Enter student classroom (Grade 1, Grade 2, etc):'
    classroom = gets.chomp
    puts 'Enter student parent permission (Y/N):'
    parent_permission = gets.chomp.to_s == 'Y'
    @people << Student.new(age, name, parent_permission, classroom)
    puts "\n"
    puts "Student #{name} created!"
  end

  def create_teacher
    puts 'Enter teacher name:'
    name = gets.chomp
    puts 'Enter teacher age:'
    age = gets.chomp.to_i
    puts 'Enter teacher specialization:'
    specialization = gets.chomp
    @people << Teacher.new(name, age, specialization)
    puts "\n"
    puts "Teacher #{name} created!"
  end

  def create_rental
    puts 'Enter person index from list below (Not ID):'
    list_people
    person_id = gets.chomp.to_i
    person = @people[person_id]
    if check_permissom(person)
      puts 'Enter book index from list below (Not ID):'
      list_books
      book_id = gets.chomp.to_i
      puts 'Enter rental date (YYYY-MM-DD):'
      date = gets.chomp
      @rentals << Rental.new(date, @people[person_id], @books[book_id])
      puts "\n"
      puts 'Rental created!'
    else
      puts 'You do not have permission to rent books!'
    end
  end

  def create_book
    puts 'Enter book title: '
    title = gets.chomp
    puts 'Enter book author: '
    author = gets.chomp
    @books << Book.new(title, author)
    puts "\n"
    puts "Book #{title} created!"
  end

  def list_rentals_by_person_id
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i
    puts "List of rentals for person id #{person_id}:"
    @rentals.each { |rental| puts rental.to_s if rental.person.id == person_id }
  end

  def run
    loop do
      option = show_menu
      case option
      when '1'
        list_books
      when '2'
        list_people
      when '3'
        create_person
      when '4'
        create_book
      when '5'
        create_rental
      when '6'
        list_rentals_by_person_id
      else
        end_program(option)
        break
      end
    end
  end

  def end_program(option)
    puts option == '7' ? 'Goodbye!' : 'Invalid option. Try again.'
  end

  def check_permissom(person)
    person.can_use_services?
  end

  def create_person
    puts 'Do you want to create a 1) Student or 2) Teacher: [Input 1 or 2]'
    option = gets.chomp
    case option
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid option!'
    end
  end
end
