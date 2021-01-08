
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

  #  ------------------------------------------------ PLAYERS CATEGORY -------------------------------------------------------- 
    
      #Players main. User selects or search for new player
      
        def players_home
          clear_terminal
          puts "What player are you looking for?"
          divider
  
          puts "Select from the items below:"
          puts "1) Players resume"
          puts "2) Top 10 Goal scores"
          puts "3) Top 10 Goal keepers"
          puts "4) Top 10 Defenders"
          puts "5) Top 10 Dangerous players"
          puts "\n ~~ (Q)uit or (R)estart ~~" 
  
          choice = get_user_input.upcase
          case choice
          when "1"
            player_info
          when "2"
            table_top_10_Goal_scores
          when "3"
            table_top_10_GoalKeepers
          when "4"
            table_top_10_Defenders
          when "5"
            table_top_danger

          when "Q" || "QUIT"
          when "R" || "RESTART"
            run
              else
            error
          end
        end

            # Player_info Display a resume of the player that the user selects tipying the name.

            def player_info
              
              clear_terminal
              puts "Enter the name of the player"
              query = get_user_input
              player_info = Player.all.find_by(name: "#{query}")
              #binding.pry
              clear_terminal
              divider
              puts "#{player_info.name} is a great #{player_info.position} who plays in #{player_info.club_id} and has score #{player_info.goals} playing #{player_info.minutes} minutes this season"
              puts "#{player_info.name} had comitted #{player_info.fouls_committed} fouls and has #{player_info.yellow_cards} yellow cards and #{player_info.red_cards}"
              divider
              default_options
               
            end
            # Top ten ten golies calls the method top_goals from players
            def table_top_10_Goal_scores
              i=1
              clear_terminal
              divider
              Player.top_goals.each do |player_instance|
              puts "\n #{i}. #{player_instance}"
              i += 1
              end
              divider
              default_options
            end

            # Top ten ten Goalkeepers the method top_goalkeeper from players

            def table_top_10_GoalKeepers
              i=1
              clear_terminal
              divider
              Player.top_goalkeeper.each do |player_instance|
              puts "\n #{i}. #{player_instance}"
              i += 1
              end
              divider
              default_options
            end
            
            # Calls the method top_defenders from players

            def table_top_10_Defenders
              i=1
              clear_terminal
              divider
              Player.top_defense.each do |player_instance|
              puts "\n #{i}. #{player_instance}"
              i += 1
              end
              divider
              default_options
            end
            # Calls the method top_danger from players

            def table_top_danger
              i=1
              clear_terminal
              divider
              Player.danger_points.each do |player_instance|
              puts "\n #{i}. #{player_instance}"
              i += 1
              end
              divider
              default_options
            end
              
 #  ------------------------------------------------ CLUBS ------------------------------------------------------------------------- 










 



#  ------------------------------------------------ CLI ACCESSORIES METHODS -------------------------------------------------------- 

  
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

  def default_options

    puts "\n ** (B)ack **"
    puts "\n ~~ (Q)uit or (R)estart ~~" 
              
    choice = get_user_input.upcase
     case choice
     when "B"
     home
     when "Q" || "QUIT"
     when "R" || "RESTART"
      run
     else
     error
      end
    end


    #  ------------------------------------------------ ABORT USERS METHODS -------------------------------------------------------- 

  # return a list of the players that the user storaged in his list

            # def my_players
            #   clear_terminal
            #   #create template 
            #   puts "#{User.players.map{|u|u.name}}"

            #   divider
            # end

                       #   clear_terminal
            #   puts "Enter the name of the player"
            #   query = get_user_input
            #   player_info = Player.all.find_by(name: "#{query}")
            #   #binding.pry
            #   clear_terminal
            #   divider
            #   puts "#{player_info.name} is a great #{player_info.position} who plays in #{player_info.club_id} and has score #{player_info.goals} playing #{player_info.minutes} minutes this season"
            #   puts "#{player_info.name} had comitted #{player_info.fouls_committed} fouls and has #{player_info.yellow_cards} yellow cards and #{player_info.red_cards}"
            #   divider
            #   puts "\n ** Add this player to your list?  PRESS (A) **"
            #   puts "\n ** (1)Back **"
            #   puts "\n ~~ (Q)uit or (R)estart ~~" 
              
            #   choice = get_user_input.upcase
            #   case choice
            #     when "B"
            #      home
            #     when "A"
            #       query = @user.
            #     when "Q" || "QUIT"
            #     when "R" || "RESTART"
            #       run
            #     else
            #       error
            #   end
            # end