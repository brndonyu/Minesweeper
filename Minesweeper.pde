import de.bezier.guido.*;
//Declare and initialize constants NUM_ROWS and NUM_COLS = 20
public final static int NUM_ROWS = 5;
public final static int NUM_COLS = 5;
public final static int NUM_MINES = 4;
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
    /*if(isFlagged == true){
        fill(0);
    }*/
    if(isWon() == true)
        displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //your code here
    System.out.println("lose");
}
public void displayWinningMessage()
{
    //your code here
}
public boolean isValid(int r, int c)
{
    if(r < NUM_ROWS && r >= 0 && c < NUM_COLS && c >= 0){
        return false;
    }
    return false;
}
public int countMines(int row, int col)
{
    int numMines = 0;
    //your code here

    for(int i=row-1; i<row+1 ;i++){
        for(int c=col-1; c<col+1; c++){
            if(isValid(row,col) && mines.contains(buttons[row][col])){
                numMines++;
            }
        }
    }
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

    // called by manager
    public void mousePressed() 
    {
        if(mouseButton == LEFT)
        {   
            clicked = true;
            if(isValid(myRow,myCol) == true)
                {
                    System.out.println(myRow + " , " + myCol);
                }
            else if(isValid(myRow,myCol) && mines.contains(buttons[myRow][myCol]))
            {
                displayLosingMessage();
            }
        //your code here

            if(isValid(myRow,myCol-1) == true && buttons[myRow][myCol-1].clicked == false)
            {
                buttons[myRow][myCol-1].mousePressed();
            }
            if(isValid(myRow,myCol-1) == true && buttons[myRow][myCol-1].clicked == false)
            {
                buttons[myRow][myCol-1].mousePressed();
            }
            
            if(isValid(myRow,myCol+1) == true && buttons[myRow][myCol+1].clicked == true)
            {
                buttons[myRow][myCol+1].mousePressed();
            }
            
            if(isValid(myRow-1,myCol) && buttons[myRow-1][myCol].clicked)
            {
                buttons[myRow-1][myCol].mousePressed();
            }
            
            if(isValid(myRow+1,myCol) && buttons[myRow+1][myCol].clicked)
            {
                buttons[myRow+1][myCol].mousePressed();
            }
        }
        
        if(mouseButton == RIGHT && !flagged)
            {
                flagged = true;
                clicked = true;
            }
        else if(mouseButton == RIGHT && flagged == true)
            {
                flagged = false;
                clicked = false;
            }
    
    }
    public void draw () 
    {    
        if (flagged)
            fill(0);
        else if( clicked && mines.contains(this) ) 
             fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(myLabel,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        myLabel = newLabel;
    }
    public void setLabel(int newLabel)
    {
        myLabel = ""+ newLabel;
    }
    public boolean isFlagged()
    {
        return flagged;
    }
}
