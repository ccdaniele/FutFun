class CLI
    def run
      sign_in
      home
    end

   
    
    def sign_in
      clear_terminal
      puts "Hello, welcome to FootFan the home of the 10.000 Football stats!"
      divider
      puts "Please create enter your USERNAME or type to create a new one"
      username = get_user_input
      @user = User.find_or_create_by(username: username)
    end



    # def home
    #   puts "*" * 30
    #   puts "\n"
    #   puts "Hi football fan"
    #   puts "\n"
    #   puts "*" * 30
  

    #   gets.chomp
      
    #   run

    # end
  
    def home
      clear_terminal
      puts "<3 Hi #{@user.username}, what do you want to do today? <3"
      divider
  
      puts "Select from the items below:"
      puts "1) Look for players information"
      puts "1) Look for teams information"
      puts "3) Look for league information"
      puts "\n ~~ (Q)uit or (R)estart ~~" 
  
      # choice = get_user_input.upcase
      
      # case choice
      # when "1"
      # when "2"
      #   playing_now
      # when "3"
      #   search
      # when "4"
      #   sign_in
      # when "Q" || "QUIT"
      # when "R" || "RESTART"
      #   run
      # else
      #   puts "Oops try again..."
      #   pause
      #   home
      # end
    end
  
    # def playing_now
    #   clear_terminal
    #   puts "Movies Playing Now"
    #   divider
  
    #   @movies = MovieAPI.playing_now
    #   puts_from_api(@movies)
    # end
  
    # def search
    #   clear_terminal
    #   puts "Search"
    #   divider
  
    #   puts "Enter a movie title to continue"
    #   query = get_user_input
  
    #   @movies = MovieAPI.search(query)
    #   puts_from_api(@movies)
    # end
  
    # def puts_from_api(movies)
    #   movies.each_with_index do |movie, i|
    #     puts "#{i + 1}) #{movie['title']}"
    #   end
    # end
  
    def get_user_input
      gets.chomp
    end
  
    def clear_terminal
      system "clear"
    end
  
    def pause
      sleep 1
    end
  
    def divider
      puts "*" * 30
      puts "\n"
      pause
    end
  end