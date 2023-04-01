`create view vw_signedprograms as  `
`select r.* `
`from program p `
`inner join recorded r `
` on p.starttime = r.progstart `
` and p.title = r.title `
` and p.subtitle = r.subtitle `
` and p.subtitletypes like '%SIGNED%';`

then

`mysql> select * from vw_signedprograms;`