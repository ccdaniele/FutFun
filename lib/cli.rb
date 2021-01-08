require "tty-prompt"
class CLI 
  @prompt = TTY::Prompt.new
  
  def run
      sign_in
      home
    end


    #Identify / create a new User
  def sign_in
      clear_terminal
      puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
      puts "     ()      |||  ||||  ||      ||      |||  ||||  ||||     ||||||||||"            
      puts "   /|||  |||||||  ||||  ||||  ||||  |||||||  ||||  ||||  |   ||||||||   "
      puts "    |||      |||  ||||  ||||  ||||      |||  ||||  ||||  ||    "
      puts "    |||  |||||||  ||||  ||||  ||||  |||||||  ||||  ||||  |||   |"
      puts "   /  |  |||||||  ||||  ||||  ||||  |||||||  ||||  ||||  |||   |"
      puts "   |  |  ||||||||      |||||  ||||  ||||||||      |||||  ||||  |"
      puts "  0   ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
      puts "|||||||||by Fujita - Calderon|||||||||||||||||||||||"
      puts "Hello, welcome to FUTFUN the home of the 10.000 soccer stats!"
      divider
      puts "Please enter your USERNAME or type to create a new one"
      username = get_user_input
      @user = User.find_or_create_by(name: username)
  end


    # Main menu shows the 3 main categories to the user 
  def home
      @prompt = TTY::Prompt.new
      clear_terminal
      divider
      choice = @prompt.select("Hi,#{@user.name} what do you want to do today?",
        ["Look for players information","Look for Clubs information","Look for league information", "Trivia"],"-> Quit","-> Restart" )
      divider
      case choice
      when "Look for players information"
        players_home
      when "Look for Clubs information"
        club_identification
      when "Look for league information"
        leagues_identification   
      when "Trivia"
        intro_trivia
      when "3"
        league_home
      when "-> Quit" || "QUIT"
      when "-> Restart" || "RESTART"
        run
      else
        puts "Oops you miss the goal, try again..."
        pause
        home
      end
    end
  end

  #  ------------------------------------------------ PLAYERS CATEGORY -------------------------------------------------------- 
    
  #Players main. displays the options for players
  def players_home
    @prompt = TTY::Prompt.new
    clear_terminal
    choice = @prompt.select("Tell me, #{@user.name} what player are you looking for today?",
      ["Players resume","Top 10 scorers of the league","Top 10 goalkeepers", "Top 10 defenders", "Top 10 dangerous players"],"-> Back","-> Quit","-> Restart" )
    divider
    case choice
    when "Players resume"
      player_info
    when "Top 10 scorers of the league"
      table_top_10_Goal_scores
    when "Top 10 goalkeepers" 
      table_top_10_GoalKeepers
    when "Top 10 defenders"
      table_top_10_Defenders
    when "Top 10 dangerous players"
      table_top_danger
    when "-> Back"
      home
    when "-> Quit" || "QUIT"
    when "-> Restart" || "RESTART"
      run
        else
      error
    end
  end

   # Player_info Display a resume of the player that the user selects tipying the name.


  def player_info
    
    clear_terminal
    @prompt = TTY::Prompt.new
    puts "Enter the name of the player"
    query = get_user_input
    if Player.all.find_by(name: "#{query}") == nil
      clear_terminal
      puts "Try with hockey, that guy doesn't play soccer!"
      pause
      pause
      player_info  
    else player_info = Player.all.find_by(name: "#{query}") 
    end
    clear_terminal
    divider
    choice = @prompt.select("#{player_info.name} is a great #{player_info.position} who plays in #{player_info.club_id} and has score #{player_info.goals} playing #{player_info.minutes} minutes this season. He had comitted #{player_info.fouls_committed} fouls and has #{player_info.yellow_cards} yellow cards and #{player_info.red_cards}",
      ["-> Back","-> Quit","-> Restart"])
    case choice
    when "-> Back"
      players_home
    when "-> Quit" || "QUIT"
    when "-> Restart" || "RESTART"
      run
        else
      error
    end
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
    choice = @prompt.select("",
      ["-> Back","-> Quit","-> Restart"])
    case choice
    when "-> Back"
      players_home
    when "-> Quit" || "QUIT"
    when "-> Restart" || "RESTART"
      run
        else
      error
    end
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
    choice = @prompt.select("",
      ["-> Back","-> Quit","-> Restart"])
    case choice
    when "-> Back"
      players_home
    when "-> Quit" || "QUIT"
    when "-> Restart" || "RESTART"
      run
        else
      error
    end
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
    choice = @prompt.select("",
      ["-> Back","-> Quit","-> Restart"])
    case choice
    when "-> Back"
      players_home
    when "-> Quit" || "QUIT"
    when "-> Restart" || "RESTART"
      run
        else
      error
    end
  end

  # Calls the method top_danger from players
  def table_top_danger
    i=1
    clear_terminal
    divider
    
    Player.top_danger.each do |player_instance|
    puts "\n #{i}. #{player_instance}"
    i += 1
    end
    choice = @prompt.select("",
      ["-> Back","-> Quit","-> Restart"])
    case choice
    when "-> Back"
      players_home
    when "-> Quit" || "QUIT"
    when "-> Restart" || "RESTART"
      run
        else
      error
    end
  end
              
 #  ------------------------------------------------ CLUBS ------------------------------------------------------------------------- 


  # Identify team 
  def club_identification
    clear_terminal
    divider
    puts "Ok #{@user.name}, choose a team!!"
    divider
    puts "Type the name of the team"
    @club_name = get_user_input
      if Club.find_club_by_name(@club_name) == nil
        clear_terminal
        puts "Hey mate! that's a Rugby team"
        sleep 2
        club_identification
      else
      @club = Club.find_club_by_name(@club_name)
      end
      clubs_home
    end

 #Clubs main. displays the options for clubs

    def clubs_home
       @prompt = TTY::Prompt.new
        clear_terminal
        choice = @prompt.select("Here you have all that you need to know about #{@club_name}!!!",
        ["About the Club","Club Stats","Club Roster", "Club Players Ratings", "Club Minutes"],"-> Back","-> Quit","-> Restart" )
        divider
          case choice
          when "About the Club"
            about_clubs
          when "Club Stats"
            clubs_stats
          when "Club Roster"
            clubs_roster
          when "Club Players Ratings"
            clubs_players_rating
          when "Club Minutes"
            clubs_minutes
          when "-> Back"
            home
          when "-> Quit" || "QUIT"
          when "-> Restart" || "RESTART"
            run
              else
            error
          end
    end


        def about_clubs
          clear_terminal
          divider
          @club.club_info
          divider
          choice = @prompt.select("",
                ["-> Back","-> Quit","-> Restart"])
              case choice
              when "-> Back"
                clubs_home
              when "-> Quit" || "QUIT"
              when "-> Restart" || "RESTART"
                run
                  else
                error
              end
            end

      
            def clubs_stats
              clear_terminal
              divider
              @club.club_stats
              divider
              choice = @prompt.select("",
                    ["-> Back","-> Quit","-> Restart"])
                  case choice
                  when "-> Back"
                    clubs_home
                  when "-> Quit" || "QUIT"
                  when "-> Restart" || "RESTART"
                    run
                      else
                    error
                  end
                end

                def clubs_roster
                  clear_terminal
                  divider
                  @club.roster_names
                  divider
                  choice = @prompt.select("",
                        ["-> Back","-> Quit","-> Restart"])
                      case choice
                      when "-> Back"
                        clubs_home
                      when "-> Quit" || "QUIT"
                      when "-> Restart" || "RESTART"
                        run
                          else
                        error
                      end
                    end

                    def clubs_players_rating
                      clear_terminal
                      divider
                      @club.club_ratings
                      divider
                      choice = @prompt.select("",
                            ["-> Back","-> Quit","-> Restart"])
                          case choice
                          when "-> Back"
                            clubs_home
                          when "-> Quit" || "QUIT"
                          when "-> Restart" || "RESTART"
                            run
                              else
                            error
                          end
                        end


                        def clubs_minutes
                          clear_terminal
                          divider
                          @club.club_minutes
                          divider
                          choice = @prompt.select("",
                                ["-> Back","-> Quit","-> Restart"])
                              case choice
                              when "-> Back"
                                clubs_home
                              when "-> Quit" || "QUIT"
                              when "-> Restart" || "RESTART"
                                run
                                  else
                                error
                              end
                            end
    

#  ------------------------------------------------ LEAGUES   -------------------------------------------------------- 


            # Identify team 

             def leagues_identification
              @prompt = TTY::Prompt.new
              clear_terminal
              choice = @prompt.select("Ok #{@user_name}, choose a League!!",
              ["Premier League","La Liga","Serie A", "Bundesliga", "MLS", "other?"],"-> Back","-> Quit","-> Restart")
              case choice
              when "Premier League"
                @league_name = "Premier League"
                  @league = League.find_league(@league_name)
                leagues_home
              when "La Liga"
                @league_name  = "Primera Division"
                  @league = League.find_league(@league_name)
                leagues_home
              when "Bundesliga"
                @league_name  = "Bundesliga 1"
                  @league = League.find_league(@league_name)
                leagues_home
              when "MLS"
                "Major League Soccer"
                @league_name  = "Major League Soccer"
                  @league = League.find_league(@league_name)
                  leagues_home
              when "other?"
                puts "Type the name of the league"
                @league_name = get_user_input
                if League.find_league(@league_name) == nil
                  clear_terminal
                  puts "Hey! esto no es Baseball papi"
                  pause
                  pause
                  leagues_identification
                else
                  @league = League.find_league(@league_name)
                end
                leagues_home
                when "-> Back"
                home
                when "-> Quit" || "QUIT"
                when "-> Restart" || "RESTART"
                run
                  else
                error
              end
            end
            
              
            def leagues_home
              @prompt = TTY::Prompt.new
               clear_terminal
               choice = @prompt.select("Here you have all that you need to know about #{@league_name}!!!",
               ["Clubs of the league stats","Clubs of the league","Most clean sheets", "Display Standings", "League with most red cards"],"-> Back","-> Quit","-> Restart" )
               divider
                 case choice
                 when "Clubs of the league stats"
                  clubs_of_the_league_stats
                 when "Clubs of the league"
                  clubs_of_the_league
                 when "Most clean sheets"
                  most_clean_sheets
                 when "Display Standings"
                   display_standings
                  when "League with most red cards"
                    league_with_more_red_cards
                 when "-> Back"
                   home
                 when "-> Quit" || "QUIT"
                 when "-> Restart" || "RESTART"
                   run
                     else
                   error
                 end
               end


                 def clubs_of_the_league_stats
                  clear_terminal
                  divider
                  @league.league_clubs_stats
                  divider
                  choice = @prompt.select("",
                        ["-> Back","-> Quit","-> Restart"])
                      case choice
                      when "-> Back"
                        leagues_home
                      when "-> Quit" || "QUIT"
                      when "-> Restart" || "RESTART"
                        run
                          else
                        error
                      end
                    end


                    def clubs_of_the_league
                      clear_terminal
                      divider
                      @league.club_names
                      divider
                      choice = @prompt.select("",
                            ["-> Back","-> Quit","-> Restart"])
                          case choice
                          when "-> Back"
                            leagues_home
                          when "-> Quit" || "QUIT"
                          when "-> Restart" || "RESTART"
                            run
                              else
                            error
                          end
                        end

                        def most_clean_sheets
                          clear_terminal
                          divider
                          League.most_clean_sheets
                          divider
                          choice = @prompt.select("",
                                ["-> Back","-> Quit","-> Restart"])
                              case choice
                              when "-> Back"
                                leagues_home
                              when "-> Quit" || "QUIT"
                              when "-> Restart" || "RESTART"
                                run
                                  else
                                error
                              end
                            end

                            def display_standings
                              clear_terminal
                              divider
                              @League.display_standings
                              divider
                              choice = @prompt.select("",
                                    ["-> Back","-> Quit","-> Restart"])
                                  case choice
                                  when "-> Back"
                                    leagues_home
                                  when "-> Quit" || "QUIT"
                                  when "-> Restart" || "RESTART"
                                    run
                                      else
                                    error
                                  end
                                end

                                def league_with_most_red_cards
                                  clear_terminal
                                  divider
                                  League.display_most_red_cards
                                  divider
                                  choice = @prompt.select("",
                                        ["-> Back","-> Quit","-> Restart"])
                                      case choice
                                      when "-> Back"
                                        leagues_home
                                      when "-> Quit" || "QUIT"
                                      when "-> Restart" || "RESTART"
                                        run
                                          else
                                        error
                                      end
                                    end
                                 




#  ------------------------------------------------ GAMES -------------------------------------------------------- 

def intro_trivia
puts "So, do you think that you know a lot about Soccer? Respond the following trivias"
choice = @prompt.select("",
  ["Go for it!","-> Back","-> Quit","-> Restart"])
case choice
when "Go for it!"
  trivia_1
when "-> Back"
  clubs_home
when "-> Quit" || "QUIT"
when "-> Restart" || "RESTART"
  run
    else
  error
end
end


def trivia_1
  @points = 0
  @prompt = TTY::Prompt.new
   clear_terminal
   choice = @prompt.select("What's the player with more goals in the history?", 
    ["Cristiano Ronaldo", "Pele", "Messi", "Josef Bican"], "-> Back","-> Quit","-> Restart" )
   divider
     case choice
     when "Cristiano Ronaldo"
      wrong_answer
      "Pele"
      wrong_answer
     when "Messi"
      wrong_answer
     when "Josef Bican"
      puts "Oh right! Josef score more than 805 goals!!!" 
      correct_answer
      trivia_2
     when "-> Back"
       home
     when "-> Quit" || "QUIT"
     when "-> Restart" || "RESTART"
       run
         else
       error
     end
   end

   def trivia_2
    @prompt = TTY::Prompt.new
     clear_terminal
     choices = ["Sheffield Football Club", "Real Madrid", "Evan Fujita's Chicago coding Boys", "Manchester City"]
     choice = @prompt.select("What's the olderst team in the history?",
     choices, "-> Back","-> Quit","-> Restart" )
     divider
       case choice
       when "Real Madrid"
        wrong_answer
       when "Evan Fujita's Chicago coding Boys"
        puts "This team is really good, but it is not the oldest, try again"
        pause
        wrong_answer
       when "Manchester City"
        wrong_answer
       when "Sheffield Football Club"
        puts "Sure, it's older than Dolly Parton" 
        correct_answer
        trivia_3
       when "-> Back"
         home
       when "-> Quit" || "QUIT"
       when "-> Restart" || "RESTART"
         run
           else
         error
       end
     end
 
     def trivia_3
      @prompt = TTY::Prompt.new
       clear_terminal
       choices = ["Venezuela", "Germany", "Uruguay", "Brazil"]
       choice = @prompt.select("What's the national club with more world cups in the history?",
       choices, "-> Back","-> Quit","-> Restart" )
       divider
         case choice
         when "Venezuela"
          wrong_answer
         when "Germany"
          wrong_answer
         when "Uruguay"
          wrong_answer
         when "Brazil"
          puts "Obrigado! Brazil has 5 world cups goals!!!" 
          correct_answer
          puts "Your score is #{@points}"
          trivia_4
         when "-> Back"
           home
         when "-> Quit" || "QUIT"
         when "-> Restart" || "RESTART"
           run
             else
           error
         end
       end

       def trivia_4
        @prompt = TTY::Prompt.new
         clear_terminal
         choices = ["England", "Germany", "Uruguay", "Brazil"]
         choice = @prompt.select("What national club won the first world cup in the history?",
         choices, "-> Back","-> Quit","-> Restart" )
         divider
           case choice
           when "Venezuela"
            wrong_answer
           when "Germany"
            wrong_answer
           when "Brazil"
            wrong_answer
           when "Uruguay"
            puts "Vamo arriba bo! The firts world cup was in Uruguay in 1930 and they won!!!" 
            @points += 16 
            sleep 5
           end_game
           when "-> Back"
             home
           when "-> Quit" || "QUIT"
           when "-> Restart" || "RESTART"
             run
               else
             error
           end
         end


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

    def wrong_answer
      puts "Wrong, study more"
      sleep 3
      puts "Your score is #{@points}"
      sleep 2
      home
    end

    def correct_answer
      @points += 16 
      sleep 3
      puts "Your score is #{@points}"
      sleep 2
    end


   def end_game
    puts "Awesome you have #{@points}"
    sleep 5
    home
   end

  # def default_options
  #   choice = @prompt.select()
  #     ["-> Back","-> Quit","-> Restart"] )
  #   puts "\n ** (B)ack **"
  #   puts "\n ~~ (Q)uit or (R)estart ~~" 
              
  #   choice = get_user_input.upcase
  #    case choice
  #    when "B"
  #    home
  #    when "-> Back"
  #    when "Q" || "QUIT"
  #    when "R" || "RESTART"
  #     runc
  #    else
  #    error
  #     end
  #   end


    #  ------------------------------------------------ ABORT METHODS -------------------------------------------------------- 

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



            # def home
            #   @prompt = TTY::Prompt.new
            #   clear_terminal
            #   divider
            #   @prompt.select("Hi, what do you want to do today?",
            #     ["Look for players information","Look for teams information","Look for league information"])
            #   puts "Hi #{@user.name}, what do you want to do today?"
            #   divider
            #   puts "Select from the items below:"
            #   puts "1) Look for players information"
            #   puts "2) Look for teams information"
            #   puts "3) Look for league information"
            #   puts "\n ~~ (Q)uit or (R)estart ~~" 
          
            #   choice = get_user_input.upcase
              
            #   case choice
            #   when "1"
            #     players_home
            #   when "2"
            #     club_identification
            #   when "3"
            #     league_home
            #   when "Q" || "QUIT"
            #   when "R" || "RESTART"
            #     run
            #   else
            #     puts "Oops try again..."
            #     pause
            #     home
            #   end
            # end

            # def leagues_identification
            #   @prompt = TTY::Prompt.new
            #   clear_terminal
            #   choice = @prompt.select("Ok #{@user_name}, choose a League!!",
            #   ["Premier League","La Liga","Serie A", "Bundesliga", "MLS", "other?"],"-> Back","-> Quit","-> Restart")
            #   case choice
            #   when "Premier League"
            #     @league_name = "Premier League"
            #     if League.find_league(@league_name) == nil
            #       clear_terminal
            #       puts "Hey! esto no es Baseball papi"
            #       pause
            #       pause
            #       leagues_identification
            #     else
            #       @league = League.find_league(@league_name)
            #     end
            #     leagues_home
            #   when "La Liga"
            #     @league_name  = "Primera Division"
            #     if League.find_league(@league_name) == nil
            #       clear_terminal
            #       puts "Hey! esto no es Baseball papi"
            #       pause
            #       pause
            #       leagues_identification
            #     else
            #       @league = League.find_league(@league_name)
            #     end
            #     leagues_home
            #   when "Bundesliga"
            #     @league_name  = "Bundesliga 1"
            #     if League.find_league(@league_name) == nil
            #       clear_terminal
            #       puts "Hey! esto no es Baseball papi"
            #       pause
            #       pause
            #       leagues_identification
            #     else
            #       @league = League.find_league(@league_name)
            #     end
            #     leagues_home
            #   when "MLS"
            #     "Major League Soccer"
            #   when "other?"
            #     puts "Type the name of the league"
            #     @league_name = get_user_input
            #     if League.find_league(@league_name) == nil
            #       clear_terminal
            #       puts "Hey! esto no es Baseball papi"
            #       pause
            #       pause
            #       leagues_identification
            #     else
            #       @league = League.find_league(@league_name)
            #     end
            #     leagues_home
            #     when "-> Back"
            #     home
            #     when "-> Quit" || "QUIT"
            #     when "-> Restart" || "RESTART"
            #     run
            #       else
            #     error
            #   end
            # end

             # Identify team 
            
                       
                      #   #  ------------------------------------------------ LEAGUES   -------------------------------------------------------- 
          












                      
                      
                      
                      
                      #    def clubs_of_the_league_stats
                      #     clear_terminal
                      #     divider
                          
                      #     @league.league_clubs_stats
                      #     divider
                      #     choice = @prompt.select("",
                      #           ["-> Back","-> Quit","-> Restart"])
                      #         case choice
                      #         when "-> Back"
                      #           clubs_home
                      #         when "-> Quit" || "QUIT"
                      #         when "-> Restart" || "RESTART"
                      #           run
                      #             else
                      #           error
                      #         end
                      #       end
                      
                      #       def clubs_of_the_league
                      #         clear_terminal
                      #         divider
                      #         @league.club_names
                      #         divider
                      #         choice = @prompt.select("",
                      #               ["-> Back","-> Quit","-> Restart"])
                      #             case choice
                      #             when "-> Back"
                      #               clubs_home
                      #             when "-> Quit" || "QUIT"
                      #             when "-> Restart" || "RESTART"
                      #               run
                      #                 else
                      #               error
                      #             end
                      #           end
                      
                      
                      #           def clubs_of_the_league
                      #             clear_terminal
                      #             divider
                                  
                      #             @league.club_names
                      #             divider
                      #             choice = @prompt.select("",
                      #                   ["-> Back","-> Quit","-> Restart"])
                      #                 case choice
                      #                 when "-> Back"
                      #                   clubs_home
                      #                 when "-> Quit" || "QUIT"
                      #                 when "-> Restart" || "RESTART"
                      #                   run
                      #                     else
                      #                   error
                      #                 end
                      #               end
                      
#old one

                      # def leagues_identification
                      #   @prompt = TTY::Prompt.new
                      #   clear_terminal
                      #   choice = @prompt.select("Ok #{@user_name}, choose a League!!",
                      #   ["Premier League","La Liga","Serie A", "Bundesliga", "MLS", "other?"],"-> Back","-> Quit","-> Restart")
                      #   case choice
                      #   when "Premier League"
                      #     @league_name = "Premier League"
                      #     if League.find_league(@league_name) == nil
                      #       clear_terminal
                      #       puts "Hey! esto no es Baseball papi"
                      #       pause
                      #       pause
                      #       leagues_identification
                      #     else
                      #       @league = League.find_league(@league_name)
                      #     end
                      #     leagues_home
                      #   when "La Liga"
                      #     @league_name  = "Primera Division"
                      #     if League.find_league(@league_name) == nil
                      #       clear_terminal
                      #       puts "Hey! esto no es Baseball papi"
                      #       pause
                      #       pause
                      #       leagues_identification
                      #     else
                      #       @league = League.find_league(@league_name)
                      #     end
                      #     leagues_home
                      #   when "Bundesliga"
                      #     @league_name  = "Bundesliga 1"
                      #     if League.find_league(@league_name) == nil
                      #       clear_terminal
                      #       puts "Hey! esto no es Baseball papi"
                      #       pause
                      #       pause
                      #       leagues_identification
                      #     else
                      #       @league = League.find_league(@league_name)
                      #     end
                      #     leagues_home
                      #   when "MLS"
                      #     "Major League Soccer"
                      #   when "other?"
                      #     puts "Type the name of the league"
                      #     @league_name = get_user_input
                      #     if League.find_league(@league_name) == nil
                      #       clear_terminal
                      #       puts "Hey! esto no es Baseball papi"
                      #       pause
                      #       pause
                      #       leagues_identification
                      #     else
                      #       @league = League.find_league(@league_name)
                      #     end
                      #     leagues_home
                      #     when "-> Back"
                      #     home
                      #     when "-> Quit" || "QUIT"
                      #     when "-> Restart" || "RESTART"
                      #     run
                      #       else
                      #     error
                      #   end
                      # end

                      # def leagues_home
                      #   @prompt = TTY::Prompt.new
                      #    clear_terminal
                      #    choice = @prompt.select("Here you have all that you need to know about #{@league_name}!!!",
                      #    ["Clubs of the league stats","Clubs of the league","Club roster", "Club red cards"],"-> Back","-> Quit","-> Restart" )
                      #    divider
                      #      case choice
                      #      when "Clubs of the league stats"
                      #       clubs_of_the_league_stats
                      #      when "Clubs of the league"
                      #       clubs_of_the_league
                      #      when "Club roster"
                      #        clubs_roster
                      #      when "Club red cards"
                      #        clubs_red_cards
                      #      when "-> Back"
                      #        home
                      #      when "-> Quit" || "QUIT"
                      #      when "-> Restart" || "RESTART"
                      #        run
                      #          else
                      #        error
                      #      end
                      #    end