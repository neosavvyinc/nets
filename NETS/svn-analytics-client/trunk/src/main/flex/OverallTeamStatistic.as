package
{
	[RemoteClass(alias="com.neosavvy.svn.analytics.dto.OverallTeamStatistic")]
    [Bindable]
	public class OverallTeamStatistic
	{
		public author:String;
	    public numberOfCommits:long;
	    public numberOfFilesTouched:long;
	    public firstCommitDate:Date;
	    public lastCommitDate:Date;
	}
}