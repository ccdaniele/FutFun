class CLI
    def run
      sign_in
      home
    end

   
    # Identify / create a new User
    def sign_in
      clear_terminal
      puts "|||||||  |||||||"
      puts "|||      |||"
      puts "||||||   ||||||"
      puts "|||      |||"
      puts "|||      ||| by Fujita - Calderon"
      divider
      puts "Hello, welcome to FootFan the home of the 10.000 Football stats!"
      divider
      puts "Please enter your USERNAME or type to create a new one"
      username = get_user_input
      @user = User.find_or_create_by(name: username)
    end

    # Main menu shows the 3 main categories to the user 
    def home
      clear_terminal
      puts "Hi #{@user.name}, what do you want to do today?"
      divider
  
      puts "Select from the items below:"
      puts "1) Look for players information"
      puts "2) Look for teams information"
      puts "3) Look for league information"
      puts "\n ~~ (Q)uit or (R)estart ~~" 
  
      choice = get_user_input.upcase
      
      case choice
      when "1"
        players_home
      when "2"
        team_home
      when "3"
        league_home
      when "Q" || "QUIT"
      when "R" || "RESTART"
        run
      else
        puts "Oops try again..."
        pause
        home
      end
    end

      #  ----- PLAYERS CATEGORY -------  
    
      #Players main. User selects or search for new player
        def players_home
          clear_terminal
          puts "What do you are looking for?"
          divider
  
          puts "Select from the items below:"
          puts "1) My favorite players"
          puts "2) New player"
          puts "\n ~~ (Q)uit or (R)estart ~~" 
  
          choice = get_user_input.upcase
          case choice
          when "1"
            my_players
          when "2"
            player_search
          when "Q" || "QUIT"
          when "R" || "RESTART"
            run
              else
            error
          end
        end


    
      # return a list of the players that the user storaged in his list

            def my_players
              clear_terminal
              #create template 
              User.players.map{|u|u.name} 

              divider

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
    def error
      puts "Oops try again..."
        pause
        home
    end
  
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
      puts "*-*" * 15
      puts "\n"
      pause
    end
  end