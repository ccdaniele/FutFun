
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
                        when "La Liga"
                          @league_name  = "Primera Division"
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
                        when "Bundesliga"
                          @league_name  = "Bundesliga 1"
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
                        when "MLS"
                          "Major League Soccer"
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
                           ["Clubs of the league stats","Clubs of the league","Club roster", "Club red cards"],"-> Back","-> Quit","-> Restart" )
                           divider
                           
                             case choice
                             when "Clubs of the league stats"
                              clubs_of_the_league_stats
                             when "Clubs of the league"
                              clubs_of_the_league
                             when "Club roster"
                               clubs_roster
                             when "Club red cards"
                               clubs_red_cards
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
                                  clubs_home
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
                                      clubs_home
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
                                          clubs_home
                                        when "-> Quit" || "QUIT"
                                        when "-> Restart" || "RESTART"
                                          run
                                            else
                                          error
                                        end
                                      end


