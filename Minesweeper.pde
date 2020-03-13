import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 25;
public final static int NUM_COLS = 25;
public final static int NUM_MINES = 99;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> mines = new ArrayList <MSButton> (); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            buttons[r][c] = new MSButton(r,c);
        }
    }
    
    setMines();
   
}

public void setMines()
{
    //your code
    while(mines.size() < NUM_MINES){
        MSButton tempMine = buttons[(int)(Math.random() * NUM_ROWS)][(int)(Math.random() * NUM_COLS)];
        if(!mines.contains(tempMine))
            {
            mines.add(tempMine);
        }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    for(int r = 0; r < NUM_ROWS; r++){
        for(int c = 0; c < NUM_COLS; c++){
            if(mines.contains(buttons[r][c]) && !buttons[r][c].flagged == true){
                return false;
            }
        }
    }
    return true;
}

public void displayLosingMessage()
{
    //your code here
    noLoop();
    fill(0);
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("L");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("S");
    buttons[NUM_ROWS/2][NUM_COLS/2+4].setLabel("E");
}
public void displayWinningMessage()
{
    //your code here
    noLoop();
    fill(0);
    buttons[NUM_ROWS/2][NUM_COLS/2-3].setLabel("Y");
    buttons[NUM_ROWS/2][NUM_COLS/2-2].setLabel("O");
    buttons[NUM_ROWS/2][NUM_COLS/2-1].setLabel("U");
    buttons[NUM_ROWS/2][NUM_COLS/2].setLabel("");
    buttons[NUM_ROWS/2][NUM_COLS/2+1].setLabel("W");
    buttons[NUM_ROWS/2][NUM_COLS/2+2].setLabel("I");
    buttons[NUM_ROWS/2][NUM_COLS/2+3].setLabel("N");
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0)
    {
        return true;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here
    if(isValid(row-1,col-1) && mines.contains(buttons[row-1][col-1])){numMines++;}
    if(isValid(row-1,col) && mines.contains(buttons[row-1][col])){numMines++;}
    if(isValid(row-1,col+1) && mines.contains(buttons[row-1][col+1])){numMines++;}
    if(isValid(row,col-1) && mines.contains(buttons[row][col-1])){numMines++;}
    if(isValid(row,col+1) && mines.contains(buttons[row][col+1])){numMines++;}
    if(isValid(row+1,col-1) && mines.contains(buttons[row+1][col-1])){numMines++;}
    if(isValid(row+1,col) && mines.contains(buttons[row+1][col])){numMines++;}
    if(isValid(row+1,col+1) && mines.contains(buttons[row+1][col+1])){numMines++;}

    return numMines;
}
public class MSButton
{
    private int myRow, myCol;
    private float x,y, width, height;
    private boolean clicked, flagged;
    private String myLabel;
    
    public MSButton ( int row, int col )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        myRow = row;
        myCol = col; 
        x = myCol*width;
        y = myRow*height;
        myLabel = "";
        flagged = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isClicked()
    {
        return clicked;
    }
    public boolean isFlagged()
    {
        return flagged;
    }

    // called by manager
    public void mousePressed() 
    {  
        clicked = true;
        if(mouseButton == RIGHT)
        {
            flagged = !flagged;
            clicked = !clicked;
        }
    if(mouseButton == LEFT){
        if(flagged == true){}
        else if(mines.contains(this)){
            displayLosingMessage();
        }
        else if(countMines(myRow,myCol) > 0)
        {
            myLabel =  "" + countMines(myRow,myCol);
        }
        else
        {
        //https://github.com/nolanalexander1/Minesweeper/blob/master/Minesweeper.pde
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked == false)
            {
                buttons[myRow-1][myCol].mousePressed();
            }
            if(isValid(myRow,myCol-1) && buttons[myRow][myCol-1].clicked == false)
            {
                buttons[myRow][myCol-1].mousePressed();
            }
            if(isValid(myRow,myCol+1) && buttons[myRow][myCol+1].clicked == false)
            {
                buttons[myRow][myCol+1].mousePressed();
            }
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked == false)
            {
               buttons[myRow+1][myCol].mousePressed();
            }
        }
    }
}
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ){
             fill(255,0,0);
        }
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        if(clicked == true)
        {
            text(myLabel,x+width/2,y+height/2);
        } 

    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }

}
