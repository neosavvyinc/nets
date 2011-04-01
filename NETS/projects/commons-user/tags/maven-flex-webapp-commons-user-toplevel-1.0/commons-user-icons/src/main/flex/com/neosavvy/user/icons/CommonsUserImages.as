package com.neosavvy.user.icons {
    public class CommonsUserImages implements ICommonsUserImages {
        
		[Embed(source='/images/accept.png')]
		private const _accept:Class;
        public function get sampleIcon():Class
        {
            return _accept;
        }
        
    }
}