import { Button } from '../../../../components/ui/button'
import AuthState from '../../../authentication/AuthState'
import {
    Table,
    TableBody,
    TableCaption,
    TableCell,
    TableHead,
    TableHeader,
    TableRow,
} from "../../../../components/ui/table"
import { FaArrowUp, FaUpload } from 'react-icons/fa'
import Sources from '../../../sources/sources'
import PieChart from './charts';


function Billboard() {
    const sources = Sources();
    return (
        <>
            <div className="">
                < AuthState />
                <Table className=" rounded  w-full text-amber-900 m-0 ">
                    <TableCaption>BillBoard</TableCaption>
                    <TableHeader>
                        <TableRow>
                            <TableHead className="w-[100px]">SOURCE</TableHead>
                            <TableHead>STATUS</TableHead>
                            <TableHead>NOTORIETY</TableHead>
                            <TableHead className="text-right">UPVOTE</TableHead>
                        </TableRow>
                    </TableHeader>
                    <TableBody>
                    {sources.map((source, index) => (
                            <TableRow key={source?.id || index}>
                                <TableCell className="font-medium">{source?.name}</TableCell>
                                <TableCell>{source?.status}</TableCell>
                                <TableCell>{source?.notoriety}</TableCell>
                                <TableCell className="text-center">
                                    <Button className="text-red-600">
                                        <FaArrowUp />
                                    </Button>
                                </TableCell>
                            </TableRow>
                        ))}
                    </TableBody>
                </Table>


            </div>

        </>
    )
}

export default Billboard