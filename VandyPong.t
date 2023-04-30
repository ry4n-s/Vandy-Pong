setscreen ("offscreenonly")

var chars : array char of boolean
var up1 : int := 50
var up2 : int := 50
var down1 : int := 1
var down2 : int := 1
var ballx, bally : int
var speedx, speedy : int := 1
var size : int := 5
var score1, score2 : int := 0
var font1 : int
var font2 : int
font1 := Font.New ("algerian:32:bold,italic")
font2 := Font.New ("algerian:32:bold,italic") %score writing
var welcomeScreen : int
welcomeScreen := Pic.FileNew ("efrom21.bmp")
var background : int
background := Pic.FileNew ("flinstones1.bmp")
var paddle : int
paddle := Pic.FileNew ("zach4.bmp")
var end1 : int
end1 := Pic.FileNew ("phil1.bmp")
var d : int := 1
var c : int := 1
var paddle2 : int
paddle2 := Pic.FileNew ("zach11.bmp")
var beginning : int
beginning := Pic.FileNew ("konrad1.bmp")
var mode : int
var background2 : int
background2 := Pic.FileNew ("zach22.bmp")
var paddle3 : int
paddle3 := Pic.FileNew ("bigfortnite.bmp")
var paddle4 : int
paddle4 := Pic.FileNew ("john.bmp")
var newb : int
newb := Pic.FileNew ("test10.bmp")

process point
    Music.PlayFile ("suge1.wav")
end point
process hit
    Music.PlayFile ("oof.wav")            %sound effects
end hit

% pick a random place on the screen to start the ball

ballx := Rand.Int (10, 100) %sets the x of the ball
bally := Rand.Int (10, 100) %sets the y of the ball
process DoMusic
    loop
	if mode = 1 then

	    Music.PlayFile ("roblox.mp3")    %music for mode 1

	elsif mode = 2 then
	    Music.PlayFile ("fortnite.mp3") %music for mode 2
	end if
    end loop
end DoMusic

Pic.Draw (beginning, 0, 0, picCopy)
View.Update
loop
    Input.KeyDown (chars)
    if chars ('1') then
	mode := 1
	paddle := paddle3
	paddle2 := paddle4
	exit                         % mode selection
    elsif chars ('2') then
	mode := 2
	background := background2

	exit



    end if
end loop
fork DoMusic
Pic.Draw (welcomeScreen, 0, 0, picCopy)
View.Update
loop
    Input.KeyDown (chars)
    exit when chars (KEY_ENTER) or chars (' ')


end loop





% loop so the animation draws over and over again

loop




    if size = 5 then
	down2 := d
	up2 := d + 50
    end if


    if size = 5 then
	down1 := c
	up1 := c + 50
    end if
    % read any keys pressed on the keyboard

    Input.KeyDown (chars)

    % makes pong bar 2 move up if up arrow pressed

    if chars (KEY_UP_ARROW) and up1 < 400 then
	c := c + 1

    end if

    % makes pong bar 2 move down if down arrow pressed

    if chars (KEY_DOWN_ARROW) and down1 > 0 then
	c := c - 1

    end if

    % makes pong bar 1 move is 'w' is pressed

    if chars ('w') and up2 < 400 then
	d := d + 1

    end if


    % makes pong bar 1 move if 's' is pressed

    if chars ('s') and down2 > 0 then
	d := d - 1

    end if


    % checks to see if ball goes off bottom of screen and makes it change direction

    if bally <= 0 then
	speedy := 1
    end if

    % checks to see if ball goes off the top of screen and makes it change direction

    if bally >= maxy then
	speedy := -1
    end if

    if ballx <= 0 then
	ballx := 320
	score2 += 1
	fork point
	delay (875)
	% adds one point to player2 when he scores a goal
    end if
    if ballx >= maxx then
	ballx := 320
	score1 += 1
	fork point
	delay (875)

	% adds one point to player1 when he scores a goal
    end if



    % draw the game on the screen

    colourback (120)
    cls
    Pic.Draw (background, 0, 0, picCopy)
    Pic.Draw (newb, ballx - 2, bally - 2, picMerge)


    Pic.Draw (paddle, 20, d, picCopy)

    % draws pong bar 1
    %drawfillbox (600, up1, 610, down1, green)
    Pic.Draw (paddle2, 600, c, picCopy)

    Font.Draw (intstr (score1), 30, 350, font1, 43)
    Font.Draw (intstr (score2), 565, 350, font2, 43)

    View.Update
    delay (2)

    % this makes ball move to a new location

    ballx := ballx + speedx
    bally := bally + speedy

    %checks to see if ball hits pong bar 2, if it does bounce back

    if ballx = 600 and bally < up1 and bally > down1 then
	speedx := -1
	fork hit
    end if

    % checks to see if ball hits pong bar 1, if it does bounce back

    if ballx = 30 and bally < up2 and bally > down2 then
	speedx := 1
	fork hit
    end if

    exit when score1 = 23 or score2 = 23         % at what score the game finishes

end loop

Pic.Draw (end1, 0, 0, picCopy)
View.Update         % end screen


