package board;

import DBconnector.DBConnectionMgr;

public class BoardMgr {

	private DBConnectionMgr pool;
	private static final String ENCTYPE = "UTF-8";
 
	public BoardMgr()	{
		try {
			pool = DBConnectionMgr.getInstance();
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	
	
}
