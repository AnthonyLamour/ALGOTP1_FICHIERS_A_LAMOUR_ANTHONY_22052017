program conjugaison;

uses crt;

//PROCEDURE ET FONCTION

procedure affiche_fichier(var f:Textfile);
//BUT afficher le contenue d'un fichier
//ENTREE le fichier à afficher
//SORTIE le contenu du fichier

VAR
	ch:string;	//sert à afficher le contenue du fichier

BEGIN
	//vérification que le fichier existe
	{$I-}
	Reset(f);
	{$I+}
	//Si il n'existe pas alors on affiche une érreur else on affiche les fiches
	IF (IOResult <> 0) Then
		begin
			writeln(UTF8ToAnsi('Ce fichier n''existe pas.'));
		end
	ELSE
		begin
			reset(f);
			//tant que la fin du fichier n'est pas atteinte on afficher son contenu
			while not Eof(f) do
				begin
					ReadLn(f,ch);
					WriteLn(ch);
				end;
			//on ferme le fichier
			close(f);
		end;
	
END;

procedure initfichier();
//BUT initialiser le fichier
//ENTREE aucune
//SORTIE le fichier initialisé
var
	f:TextFile;
	ch:string;
BEGIN
	Assign(f,'Liste_de_verbe.txt');
	{$I-}
	Reset(f);
	{$I+}
	//Si il n'existe pas alors on le crée et on le remplie
	IF (IOResult <> 0) THEN
		begin
			rewrite(f);
			ch:='rire';
			writeln(f,ch);
			ch:='recevoire';
			writeln(f,ch);
			ch:='aller';
			writeln(f,ch);
			ch:='bouillir';
			writeln(f,ch);
			ch:='envoyer';
			writeln(f,ch);
			ch:='peindre';
			writeln(f,ch);
			ch:='habiter';
			writeln(f,ch);
			ch:='payer';
			writeln(f,ch);
			ch:='mourir';
			writeln(f,ch);
			ch:='hair';
			writeln(f,ch);
			ch:='vouloir';
			writeln(f,ch);
			ch:='finir';
			writeln(f,ch);
			ch:='s''amuser';
			writeln(f,ch);
			close(f);
		end;
END;

function determine_groupe(ch:string):integer;
//BUT déterminer le groupe d'un verbe
//ENTREE le verbe
//SORTIE le numéro de son groupe

var
	numgroupe:integer;
	terminaison,s:string;
	f:TextFile;
	test:boolean;
BEGIN
	test:=false;
	IF ch='aller' Then
		begin
			numgroupe:=3;
		end
	ELSE
		begin
			terminaison:=copy(ch,length(ch)-1,2);
			IF terminaison='er' Then
				begin
					numgroupe:=1;
				end
			ELSE
				begin
					assign(f,'liste_ir_3_groupe.txt');
					Reset(f);
					WHILE NOT (Eof(f)) DO
						begin
							readln(f,s);
							IF s=ch Then
								begin
									test:=True;
								end;
						end;
					close(f);
					IF (terminaison='ir') AND (test=false) AND (ch[length(ch)-2]<>'o') Then
						begin
							numgroupe:=2;
						end
					ELSE
						begin
							numgroupe:=3;
						end;
				end;
		end;
	determine_groupe:=numgroupe;
END;

procedure conjug(verbe:string);
//BUT conjuguer un verbe
//ENTREE le verbe
//SORTIE le verbe conjuguer

var
	f:textfile;
	numgroupe,nb:integer;
	ch,radical:string;
BEGIN
	nb:=length(verbe)-2;
	numgroupe:=determine_groupe(verbe);
	Assign(f,'Liste_de_verbe_conj.txt');
	{$I-}
	reset(f);
	{$I+}
	IF (IOResult <> 0) Then
		begin
			rewrite(f);
				if numgroupe=1 then
					begin
						ch:=verbe+' verbe du groupe 1 :';
						writeln(f,ch);
						radical:=copy(verbe,1,nb);
						if (radical[1]='a') or (radical[1]='e') or (radical[1]='i') or (radical[1]='o') or (radical[1]='u') or (radical[1]='y') Then
							begin
								ch:='j'''+radical+'e';
							end
						else
							begin
								ch:='je '+radical+'e';
							end;
						writeln(f,ch);
						ch:='tu '+radical+'es';
						writeln(f,ch);
						ch:='il/elle/on '+radical+'e';
						writeln(f,ch);
						if radical[length(radical)]='c' then
							begin
								radical:=copy(radical,1,length(radical)-1);
								ch:='Nous '+radical+'çons';
								radical:=copy(verbe,1,nb);
							end
						else
							begin
								if radical[length(radical)]='g' then
									begin
										ch:='Nous '+radical+'eons';
									end
								else
									begin
										ch:='Nous '+radical+'ons';
									end;
							end;
						writeln(f,ch);
						ch:='Vous '+radical+'ez';
						writeln(f,ch);
						ch:='Ils/elles '+radical+'ent';
						writeln(f,ch);
					end
				else
					begin
						if numgroupe=2 then
							begin
								ch:=verbe+' verbe du groupe 2 :';
								writeln(f,ch);
								radical:=copy(verbe,1,nb);
								if (radical[1]='a') or (radical[1]='e') or (radical[1]='i') or (radical[1]='o') or (radical[1]='u') or (radical[1]='y') then
									begin
										ch:='j'''+radical+'is';
									end
								else
									begin
										ch:='je '+radical+'is';
									end;
								writeln(f,ch);
								ch:='tu '+radical+'is';
								writeln(f,ch);
								ch:='il/elle/on '+radical+'it';
								writeln(f,ch)	;
								ch:='Nous '+radical+'issons';
								writeln(f,ch);
								ch:='Vous '+radical+'issez';
								writeln(f,ch);
								ch:='Ils/elles '+radical+'issent';
								writeln(f,ch);
							end
						else
							begin
								if verbe='aller' then
									begin
										ch:=verbe+' verbe du groupe 3 :';
										writeln(f,ch);
										ch:='je vais';
										writeln(f,ch);
										ch:='tu vas';
										writeln(f,ch);
										ch:='il/elle/on va';
										writeln(f,ch);
										ch:='nous allons';
										writeln(f,ch);
										ch:='vous allez';
										writeln(f,ch);
										ch:='ils/elles vont';
										writeln(f,ch);
									end
								else
									begin
										if	verbe='recevoir' then
											begin
												ch:=verbe+' verbe du groupe 3 :';
												writeln(f,ch);
												ch:='je reçois';
												writeln(f,ch);
												ch:='tu reçois';
												writeln(f,ch);
												ch:='il/elle/on reçoit';
												writeln(f,ch);
												ch:='nous recevons';
												writeln(f,ch);
												ch:='vous recevez';
												writeln(f,ch);
												ch:='ils/elles reçoivent';
												writeln(f,ch);
											end			
										else
											begin
												if verbe='bouillir' then
													begin
														ch:=verbe+' verbe du groupe 3 :';
														writeln(f,ch);
														ch:='je bous';
														writeln(f,ch);
														ch:='tu bous';
														writeln(f,ch);
														ch:='il/elle/on bout';
														writeln(f,ch);
														ch:='nous bouillons';
														writeln(f,ch);
														ch:='vous bouillez';
														writeln(f,ch);
														ch:='ils/elles bouillent';
														writeln(f,ch);
													end
												else
													begin
														if verbe='mourir' then
															begin
																ch:=verbe+' verbe du groupe 3 :';
																writeln(f,ch);
																ch:='je meurs';
																writeln(f,ch);
																ch:='tu meurs';
																writeln(f,ch);
																ch:='il/elle/on meurt';
																writeln(f,ch);
																ch:='nous mourons';
																writeln(f,ch);
																ch:='vous mourez';
																writeln(f,ch);
																ch:='ils/elles meurent';
																writeln(f,ch);
															end
														else
															begin
																if verbe='vouloir' then
																	begin
																		ch:=verbe+' verbe du groupe 3 :';
																		writeln(f,ch);
																		ch:='je veux';
																		writeln(f,ch);
																		ch:='tu veux';
																		writeln(f,ch);
																		ch:='il/elle/on veut';
																		writeln(f,ch);
																		ch:='nous voulons';
																		writeln(f,ch);
																		ch:='vous voulez';
																		writeln(f,ch);
																		ch:='ils/elles veulent';
																		writeln(f,ch);
																	end
																else
																	begin
																		ch:=verbe+' verbe du groupe 2 :';
																		writeln(f,ch);
																		radical:=copy(verbe,1,nb);
																		if (radical[1]='a') or (radical[1]='e') or (radical[1]='i') or (radical[1]='o') or (radical[1]='u') or (radical[1]='y') then
																			begin
																				ch:='j'''+radical+'s';
																			end
																		else
																			begin
																				ch:='je '+radical+'s';
																			end;
																		writeln(f,ch);
																		ch:='tu '+radical+'s';
																		writeln(f,ch);
																		ch:='il/elle/on '+radical+'t';
																		writeln(f,ch);
																		ch:='Nous '+radical+'ons';
																		writeln(f,ch);
																		ch:='Vous '+radical+'ez';
																		writeln(f,ch);
																		ch:='Ils/elles '+radical+'ent';
																		writeln(f,ch);
																	end;
															end;
													end;
											end;
									end;
							end;
					end;
			close(f);
		end
	else
		begin
			append(f);
				if numgroupe=1 then
					begin
						ch:=verbe+' verbe du groupe 1 :';
						writeln(f,ch);
						radical:=copy(verbe,1,nb);
						if (radical[1]='a') or (radical[1]='e') or (radical[1]='i') or (radical[1]='o') or (radical[1]='u') or (radical[1]='y') Then
							begin
								ch:='j'''+radical+'e';
							end
						else
							begin
								ch:='je '+radical+'e';
							end;
						writeln(f,ch);
						ch:='tu '+radical+'es';
						writeln(f,ch);
						ch:='il/elle/on '+radical+'e';
						writeln(f,ch);
						if radical[length(radical)]='c' then
							begin
								radical:=copy(radical,1,length(radical)-1);
								ch:='Nous '+radical+'çons';
								radical:=copy(verbe,1,nb);
							end
						else
							begin
								if radical[length(radical)]='g' then
									begin
										ch:='Nous '+radical+'eons';
									end
								else
									begin
										ch:='Nous '+radical+'ons';
									end;
							end;
						writeln(f,ch);
						ch:='Vous '+radical+'ez';
						writeln(f,ch);
						ch:='Ils/elles '+radical+'ent';
						writeln(f,ch);
					end
				else
					begin
						if numgroupe=2 then
							begin
								ch:=verbe+' verbe du groupe 2 :';
								writeln(f,ch);
								radical:=copy(verbe,1,nb);
								if (radical[1]='a') or (radical[1]='e') or (radical[1]='i') or (radical[1]='o') or (radical[1]='u') or (radical[1]='y') then
									begin
										ch:='j'''+radical+'is';
									end
								else
									begin
										ch:='je '+radical+'is';
									end;
								writeln(f,ch);
								ch:='tu '+radical+'is';
								writeln(f,ch);
								ch:='il/elle/on '+radical+'it';
								writeln(f,ch)	;
								ch:='Nous '+radical+'issons';
								writeln(f,ch);
								ch:='Vous '+radical+'issez';
								writeln(f,ch);
								ch:='Ils/elles '+radical+'issent';
								writeln(f,ch);
							end
						else
							begin
								if verbe='aller' then
									begin
										ch:=verbe+' verbe du groupe 3 :';
										writeln(f,ch);
										ch:='je vais';
										writeln(f,ch);
										ch:='tu vas';
										writeln(f,ch);
										ch:='il/elle/on va';
										writeln(f,ch);
										ch:='nous allons';
										writeln(f,ch);
										ch:='vous allez';
										writeln(f,ch);
										ch:='ils/elles vont';
										writeln(f,ch);
									end
								else
									begin
										if	verbe='recevoir' then
											begin
												ch:=verbe+' verbe du groupe 3 :';
												writeln(f,ch);
												ch:='je reçois';
												writeln(f,ch);
												ch:='tu reçois';
												writeln(f,ch);
												ch:='il/elle/on reçoit';
												writeln(f,ch);
												ch:='nous recevons';
												writeln(f,ch);
												ch:='vous recevez';
												writeln(f,ch);
												ch:='ils/elles reçoivent';
												writeln(f,ch);
											end			
										else
											begin
												if verbe='bouillir' then
													begin
														ch:=verbe+' verbe du groupe 3 :';
														writeln(f,ch);
														ch:='je bous';
														writeln(f,ch);
														ch:='tu bous';
														writeln(f,ch);
														ch:='il/elle/on bout';
														writeln(f,ch);
														ch:='nous bouillons';
														writeln(f,ch);
														ch:='vous bouillez';
														writeln(f,ch);
														ch:='ils/elles bouillent';
														writeln(f,ch);
													end
												else
													begin
														if verbe='mourir' then
															begin
																ch:=verbe+' verbe du groupe 3 :';
																writeln(f,ch);
																ch:='je meurs';
																writeln(f,ch);
																ch:='tu meurs';
																writeln(f,ch);
																ch:='il/elle/on meurt';
																writeln(f,ch);
																ch:='nous mourons';
																writeln(f,ch);
																ch:='vous mourez';
																writeln(f,ch);
																ch:='ils/elles meurent';
																writeln(f,ch);
															end
														else
															begin
																if verbe='vouloir' then
																	begin
																		ch:=verbe+' verbe du groupe 3 :';
																		writeln(f,ch);
																		ch:='je veux';
																		writeln(f,ch);
																		ch:='tu veux';
																		writeln(f,ch);
																		ch:='il/elle/on veut';
																		writeln(f,ch);
																		ch:='nous voulons';
																		writeln(f,ch);
																		ch:='vous voulez';
																		writeln(f,ch);
																		ch:='ils/elles veulent';
																		writeln(f,ch);
																	end
																else
																	begin
																		ch:=verbe+' verbe du groupe 2 :';
																		writeln(f,ch);
																		radical:=copy(verbe,1,nb);
																		if (radical[1]='a') or (radical[1]='e') or (radical[1]='i') or (radical[1]='o') or (radical[1]='u') or (radical[1]='y') then
																			begin
																				ch:='j'''+radical+'s';
																			end
																		else
																			begin
																				ch:='je '+radical+'s';
																			end;
																		writeln(f,ch);
																		ch:='tu '+radical+'s';
																		writeln(f,ch);
																		ch:='il/elle/on '+radical+'t';
																		writeln(f,ch);
																		ch:='Nous '+radical+'ons';
																		writeln(f,ch);
																		ch:='Vous '+radical+'ez';
																		writeln(f,ch);
																		ch:='Ils/elles '+radical+'ent';
																		writeln(f,ch);
																	end;
															end;
													end;
											end;
									end;
							end;
					end;
			close(f);
		end;
END;

//PROG PRINCIPAL

var
	f,g:TextFile;
	ch:string;
	nb:integer;
BEGIN
	clrscr;
	initfichier();
	Assign(f,'Liste_de_verbe.txt');
	affiche_fichier(f);
	writeln('Choisissez un verbe');
	readln(ch);
	conjug(ch);
	assign(g,'Liste_de_verbe_conj.txt');
	affiche_fichier(g);
	readln();
END.
